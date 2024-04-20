import aiohttp
import json
import asyncio
import logging
from logging.handlers import TimedRotatingFileHandler
from datetime import datetime
from twitchio.ext import commands
import os
from twitchio import Client, GlobalEmote

import sys
import requests
from base64 import standard_b64encode


def get_client_id():
    client_id_file = os.path.join(os.path.dirname(os.path.realpath(__file__)), '..', '..', '..', 'data', 'stream_twitch_roboty_hurts_client_id.txt')
    with open(client_id_file, 'r') as file:
        client_id = file.read().strip()
    return client_id


def get_client_secret():
    client_secret_file = os.path.join(os.path.dirname(os.path.realpath(__file__)), '..', '..', '..', 'data', 'stream_twitch_roboty_hurts_client_secret.txt')
    with open(client_secret_file, 'r') as file:
        client_secret = file.read().strip()
    return client_secret


class Bot(commands.Bot):
    def __init__(self):
        super().__init__(token=self.get_access_token(), prefix='', initial_channels=['reality_hurts'])
        self.setup_logging()
        self.global_emotes = None

    def get_access_token(self):
        access_token_file = os.path.join(os.path.dirname(os.path.realpath(__file__)), '..', '..', '..', 'data', 'stream_twitch_roboty_hurts_access_token.txt')
        with open(access_token_file, "r") as file:
            return file.read().strip()

    def setup_logging(self):
        log_formatter = logging.Formatter('%(asctime)s | %(levelname)s | %(message)s', datefmt='%Y-%m-%d | %H:%M:%S')

        log_filename = os.path.join(os.path.dirname(os.path.realpath(__file__)), '..', '..', '..', 'logs', 'chat_bot', f'{datetime.now().strftime("%Y-%m-%d")}.log')
        log_handler = TimedRotatingFileHandler(filename=log_filename, when='midnight', backupCount=0)
        log_handler.setFormatter(log_formatter)

        root_logger = logging.getLogger()
        root_logger.setLevel(logging.INFO)
        root_logger.addHandler(log_handler)

    def log_message(self, message):
        logging.info(message)

    async def get_global_emotes(self, client_id: str, token: str):
        api_url = "https://api.twitch.tv/helix/chat/emotes/global"

        headers = {
            "Client-ID": client_id,
            "Authorization": f"Bearer {token}",
        }

        # Create an aiohttp session
        async with aiohttp.ClientSession() as session:
            # Make a GET request to the API URL with the specified headers
            async with session.get(api_url, headers=headers) as response:
                # Check the status of the response
                if response.status == 200:
                    # Parse the JSON response
                    print("Emotes fetched.")
                    data = await response.json()
                    emote_dict = {}
                    for emote in data["data"]:
                        # Store emote details using emote name as the key
                        emote_dict[emote["name"]] = emote
                    return emote_dict
                else:
                    raise Exception(f"Failed to retrieve global emotes: {response.status} - {await response.text()}")

    async def event_ready(self):
        self.log_message(f'Logged in as {self.nick}')

        client_id = get_client_id()
        token = self.get_access_token()

        # Fetch global emotes and store them in the dictionary
        self.global_emotes = await self.get_global_emotes(client_id, token)

    def replace_placeholders(self, payload, placeholder_data):
        # Replace placeholders in the payload with the actual values from the dictionary
        for placeholder, value in placeholder_data.items():
            payload = payload.replace(placeholder, value)
        return payload

    def serialize_gr_command(self, **cmd):
        payload = cmd.pop('payload', None)
        cmd_str = ','.join(f'{k}={v}' for k, v in cmd.items())
        ans = []
        w = ans.append
        w(b'\033_G')
        w(cmd_str.encode('ascii'))

        if payload:
            placeholder_data = {
                # Define your placeholder mappings here
                '{placeholder}': 'value',
                # Add more mappings as needed
            }
            payload_str = self.replace_placeholders(payload.decode('utf-8'), placeholder_data)
            encoded_payload = payload_str.encode('utf-8')
            w(b';')
            w(encoded_payload)

        w(b'\033\\')
        return b''.join(ans)

    def write_chunked(self, **cmd):
        data = standard_b64encode(cmd.pop('data'))
        while data:
            chunk, data = data[:4096], data[4096:]
            m = 1 if data else 0
            sys.stdout.buffer.write(self.serialize_gr_command(payload=chunk, c=3, r=1, m=m, **cmd))
            sys.stdout.flush()

    async def main(self, image_url):
        response = requests.get(image_url)
        if response.status_code == 200:
            self.write_chunked(a='T', f=100, data=response.content)
        else:
            print(f"Failed to fetch image from URL: {image_url}")


    async def event_message(self, message):
        # Log the original message
        self.log_message(f'{message.author.name}: {message.content}')
        print(f"{message.author.name}: {message.content}")

        # Define a list to hold the parts of the message (text and emotes) in order
        message_parts = []
        
        # The current position in the message content
        current_position = 0
        
        # Process the message content and identify emotes
        while current_position < len(message.content):
            # Check if there is an emote at the current position
            # Iterate through global emotes to find matches
            emote_found = False
            for emote_name, emote_data in self.global_emotes.items():
                if message.content.startswith(emote_name, current_position):
                    # Add the emote image to the message parts
                    emote_url = emote_data["images"]["url_4x"]
                    async with aiohttp.ClientSession() as session:
                        async with session.get(emote_url) as response:
                            if response.status == 200:
                                # Fetch the image data
                                emote_content = await response.read()
                                # Add emote image to the message parts
                                message_parts.append(("emote", emote_content))
                    current_position += len(emote_name)
                    emote_found = True
                    break
            
            # If no emote was found, add text
            if not emote_found:
                # Find the next emote or the end of the content
                next_emote_pos = len(message.content)
                for emote_name in self.global_emotes.keys():
                    pos = message.content.find(emote_name, current_position)
                    if pos != -1:
                        next_emote_pos = min(next_emote_pos, pos)
                
                # Add the text segment to the message parts
                text_segment = message.content[current_position:next_emote_pos]
                message_parts.append(("text", text_segment))
                
                # Move the current position forward
                current_position = next_emote_pos

        # Print the message parts in order
        for part_type, part_content in message_parts:
            if part_type == "text":
                print(part_content, end='')
            elif part_type == "emote":
                self.write_chunked(a='T', f=100, data=part_content)

        # Newline after each message
        print()
        
        # Handle commands if any
        await self.handle_commands(message)




bot = Bot()
bot.run()
