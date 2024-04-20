import aiohttp
import json
import asyncio
import subprocess
import shlex
import logging
from logging.handlers import TimedRotatingFileHandler
from datetime import datetime
from twitchio.ext import commands
import os
from twitchio import Client, GlobalEmote
from twitchio.http import TwitchHTTP


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
                    
                    # Return the emote dictionary
                    return emote_dict
                else:
                    # Handle non-200 status codes (e.g. error handling)
                    raise Exception(f"Failed to retrieve global emotes: {response.status} - {await response.text()}")


    async def event_ready(self):
        self.log_message(f'Logged in as {self.nick}')

        client_id = get_client_id()
        token = self.get_access_token()

        # Fetch global emotes and store them in the dictionary
        self.global_emotes = await self.get_global_emotes(client_id, token)


    async def event_message(self, message):
        self.log_message(f'{message.author.name}: {message.content}')

        modified_message = message.content

        # Process the emotes in the chat message
        if 'emotes' in message.tags and message.tags['emotes']:
            emotes_str = message.tags['emotes']
            emotes_dict = {}
            for emote in emotes_str.split('/'):
                emote_id, positions_str = emote.split(':')
                positions = positions_str.split(',')
                emotes_dict[emote_id] = positions

            # Iterate through each emote and replace its text with the rendered emote
            for emote_id, positions in emotes_dict.items():
                for pos in positions:
                    start, end = map(int, pos.split('-'))
                    emote_text = message.content[start:end + 1]

                    if emote_text in self.global_emotes:
                        emote_image_url = self.global_emotes[emote_text]["images"]["url_1x"]

                        # Call the image rendering script and get the rendered emote
                        emote_rendering_process = subprocess.run(
                            ['python3', '/media/storage/Streaming/Software/scripts/dev/services/send-png_3.py', emote_image_url],
                            capture_output=True,
                            text=True
                        )

                        # Get the rendered emote output
                        rendered_emote = emote_rendering_process.stdout

                        # Replace the emote text with the rendered emote in the message
                        modified_message = modified_message[:start] + rendered_emote + modified_message[end + 1:]

        print(f'{message.author.name}: {modified_message}')

        await self.handle_commands(message)

bot = Bot()
bot.run()
