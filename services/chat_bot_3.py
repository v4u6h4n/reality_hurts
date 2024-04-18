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
from twitchio import Client, GlobalEmote  # Importing Client class from twitchio for API interactions
from twitchio.http import TwitchHTTP
# from twitchio.client import Client



def get_client_id():
    # Specify the path to the file containing the client ID
    client_id_file = '/media/storage/Streaming/Software/data/stream_twitch_roboty_hurts_client_id.txt'
    
    # Read the client ID from the file
    with open(client_id_file, 'r') as file:
        client_id = file.read().strip()
    
    return client_id

def get_client_secret():
    # Specify the path to the file containing the client secret
    client_secret_file = '/media/storage/Streaming/Software/data/stream_twitch_roboty_hurts_client_secret.txt'
    
    # Read the client secret from the file
    with open(client_secret_file, 'r') as file:
        client_secret = file.read().strip()
    
    return client_secret

# Bot.
class Bot(commands.Bot):

    def __init__(self):
        self.refresh_access_token()
        super().__init__(token=self.get_access_token(), prefix='!', initial_channels=['reality_hurts'])
        self.setup_logging()
        
        # Initialize the global emotes dictionary as None initially
        self.global_emotes = None

    def setup_logging(self):
        log_formatter = logging.Formatter('%(asctime)s | %(levelname)s | %(message)s', datefmt='%Y-%m-%d | %H:%M:%S')

        # Define the log handler with date-based rotation
        log_filename = os.path.join(os.path.dirname(os.path.realpath(__file__)), '..', '..', '..', 'logs', 'roboty_hurts', f'{datetime.now().strftime("%Y-%m-%d")}.log')
        log_handler = TimedRotatingFileHandler(filename=log_filename, when='midnight', backupCount=0)
        log_handler.setFormatter(log_formatter)

        # Add the log handler to the root logger
        root_logger = logging.getLogger()
        root_logger.setLevel(logging.INFO)
        root_logger.addHandler(log_handler)

    def log_message(self, message):
        logging.info(message)

    def refresh_access_token(self):
        script_path = os.path.join(os.path.dirname(os.path.realpath(__file__)), '..', 'configurator.sh')
        subprocess.run([script_path, "--source", "roboty_hurts_owner", "--verbose", "--stream", "refresh", "twitch", "roboty_hurts"])

    def get_access_token(self):
        token_file = os.path.join(os.path.dirname(os.path.realpath(__file__)), '..', '..', '..', 'data', 'stream_twitch_roboty_hurts_access_token.txt')
        with open(token_file, "r") as file:
            return file.read().strip()


    async def get_global_emotes(self, client_id: str, token: str):
        # Define the API URL for global emotes
        api_url = "https://api.twitch.tv/helix/chat/emotes/global"
        
        # Define the headers for the request
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
                    print("Successfully retrieving global emotes data!")
                    data = await response.json()
                    print("Successfully retrieved global emotes data!")
                    
                    # Create a dictionary to store emote names and their details
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

        # Retrieve client ID and token
        client_id = get_client_id()
        token = self.get_access_token()

        # Fetch global emotes and store them in the dictionary
        self.global_emotes = await self.get_global_emotes(client_id, token)

        # Schedule token refresh periodically
        self.loop.create_task(self.run_refresh_access_token_periodically())





    async def event_message(self, message):
        # Log the chat message.
        print(f'{message.author.name}: {message.content}')
        self.log_message(f'{message.author.name}: {message.content}')

        # Check if 'emotes' tag exists in message.tags.
        if 'emotes' in message.tags and message.tags['emotes']:
            # Parse the emotes string into a dictionary.
            emotes_str = message.tags['emotes']
            emotes_dict = {}
            for emote in emotes_str.split('/'):
                emote_id, positions_str = emote.split(':')
                positions = positions_str.split(',')
                emotes_dict[emote_id] = positions

            # Process each emote in the dictionary.
            for emote_id, positions in emotes_dict.items():
                for pos in positions:
                    # The position format is "start-end".
                    start, end = map(int, pos.split('-'))
                    emote_text = message.content[start:end + 1]
                    print(f'Emote detected: {emote_text} from {message.author.name}')

                    # Check if emote_text is in the global emotes dictionary
                    if emote_text in self.global_emotes:
                        # Get the emote's image URL from the global emotes dictionary
                        emote_image_url = self.global_emotes[emote_text]["images"]["url_4x"]
                        print(f"Emote URL: {emote_image_url}")

        # Handle any commands in the message.
        await self.handle_commands(message)





    async def run_refresh_access_token_periodically(self):
        while True:
            await asyncio.sleep(1800)
            self.refresh_access_token()

bot = Bot()
bot.run()
