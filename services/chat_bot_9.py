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
        super().__init__(token=self.get_access_token(), prefix='!', initial_channels=['reality_hurts'])
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

    async def render_and_handle_message(self, message):
        # Log the original message
        self.log_message(f'{message.author.name}: {message.content}')

        # List to store the parts of the message (text and emotes)
        parts = []
        modified_message = message.content
        emotes_to_render = []  # List to store emote data for rendering

        # Process the emotes in the chat message
        if 'emotes' in message.tags and message.tags['emotes']:
            emotes_str = message.tags['emotes']
            emotes_dict = {}
            for emote in emotes_str.split('/'):
                emote_id, positions_str = emote.split(':')
                positions = positions_str.split(',')
                emotes_dict[emote_id] = positions

            # Iterate through each emote and prepare them for rendering
            for emote_id, positions in emotes_dict.items():
                for pos in positions:
                    start, end = map(int, pos.split('-'))
                    emote_text = message.content[start:end + 1]

                    # Check if emote_text is in global_emotes
                    if emote_text in self.global_emotes:
                        emote_image_url = self.global_emotes[emote_text]["images"]["url_1x"]

                        # Add emote data for rendering
                        emotes_to_render.append((emote_text, emote_image_url, start, end))

        # Process each emote in the message
        last_pos = 0
        final_parts = []

        for emote_text, emote_image_url, start, end in emotes_to_render:
            # Add the text part before the emote
            final_parts.append(modified_message[last_pos:start])

            # Render the emote within the chat text print
            emote_data = requests.get(emote_image_url).content
            print(f"{' '.join(final_parts)} ", end='')
            print("start", self.write_chunked(a='T', f=100, data=emote_data), "end")
            final_parts = []

            # Update last position to the end of the emote
            last_pos = end + 1

        # Add the remaining text after the last emote
        final_parts.append(modified_message[last_pos:])

        # Join the remaining parts and output the final message
        final_message = ' '.join(final_parts)
        print(f'{message.author.name}: {final_message}')

        # Handle commands in the message (if any)
        await self.handle_commands(message)



    # Add a function to handle the new events
    
    async def event_message(self, message):
        # Handle the message with the updated render_and_handle_message function
        await self.render_and_handle_message(message)


# Initialize and run the bot
bot = Bot()
bot.run()
