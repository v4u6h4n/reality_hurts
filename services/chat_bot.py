import asyncio
import subprocess
import shlex
import logging
from logging.handlers import TimedRotatingFileHandler
from datetime import datetime
from twitchio.ext import commands
import os

# Bot.

class Bot(commands.Bot):

    def __init__(self):
        self.refresh_access_token()
        super().__init__(token=self.get_access_token(), prefix='!', initial_channels=['reality_hurts'])
        self.setup_logging()

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

    async def event_ready(self):
        self.log_message(f'Logged in as {self.nick}')
        self.loop.create_task(self.run_refresh_access_token_periodically())




    async def event_message(self, message):
        # Log the chat message.
        print(f'{message.author.name}: {message.content}')
        self.log_message(f'{message.author.name}: {message.content}')

        # Check if 'emotes' tag exists in message.tags.
        if 'emotes' in message.tags and message.tags['emotes']:
            # The emotes tag is a string formatted as "emote_id:positions".
            # Example: "25:0-4,12-16/1902:6-8"
            emotes_str = message.tags['emotes']
            
            # Parse the emotes string into a dictionary.
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

        # Handle any commands in the message.
        await self.handle_commands(message)


        


    async def run_refresh_access_token_periodically(self):
        while True:
            await asyncio.sleep(1800)
            self.refresh_access_token()

bot = Bot()
bot.run()
