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

        # Define permission levels
        self.permission_levels = {
            'owner': 3,
            'roommate': 2,
            'housemate': 1
        }

        # Load permissions from separate files
        self.load_permissions()

    def setup_logging(self):
        log_formatter = logging.Formatter('%(asctime)s | %(levelname)s | %(message)s', datefmt='%Y-%m-%d | %H:%M:%S')

        # Define the log handler with date-based rotation
        log_handler = TimedRotatingFileHandler(filename=f'/media/storage/Streaming/Software/logs/roboty_hurts/{datetime.now().strftime("%Y-%m-%d")}.log', when='midnight', backupCount=0)
        log_handler.setFormatter(log_formatter)

        # Add the log handler to the root logger
        root_logger = logging.getLogger()
        root_logger.setLevel(logging.INFO)
        root_logger.addHandler(log_handler)

    def log_message(self, message):
        logging.info(message)

    def refresh_access_token(self):
        subprocess.run(["/media/storage/Streaming/Software/scripts/main/configurator.sh", "-s", "brh", "-ch", "t", "rbh", "r"])

    def get_access_token(self):
        with open("/media/storage/Streaming/Software/data/channel_twitch_roboty_hurts_access_token.txt", "r") as file:
            return file.read().strip()

    async def event_ready(self):
        self.log_message(f'Logged in as {self.nick}')
        self.loop.create_task(self.run_refresh_access_token_periodically())

    async def event_message(self, message):
        if message.echo:
            return

        if message.content.startswith(self._prefix):
            log_message = f"COMMAND  | {message.content}"
        else:
            log_message = f"CHAT     | {message.content}"

        self.log_message(log_message)
        await self.handle_commands(message)

    async def run_refresh_access_token_periodically(self):
        while True:
            await asyncio.sleep(1800)
            self.refresh_access_token()

    @commands.command(aliases=['info', 'guide', 'settings', 'options', 'h', 'commands', 'menu'])
    async def help(self, ctx: commands.Context):
        await ctx.send("Commands: https://pastebin.com/ZLDyQeJE")

    @commands.command(aliases=['social', 'links', 'link', 'discord'])
    async def socials(self, ctx: commands.Context):
        await ctx.send("Socials: https://lnk.bio/reality_hurts")

    @commands.command(aliases=['r'])
    async def rules(self, ctx: commands.Context):
        await ctx.send("Rules: https://pastebin.com/MMrR6zzH")

    @commands.command(aliases=['s'])
    @commands.cooldown(1, 2, commands.Bucket.channel)
    async def scene(self, ctx: commands.Context):
        # Read the permission level string from the text file
        with open("../../data/permission_scene.txt", "r") as file:
            permission_scene = file.read().strip()

        # Check permission level
        if self.get_permission_level(ctx.author.name) < self.permission_levels[permission_scene]:
            if permission_scene == 'owner':
                    response_message = "Scene command locked."
                    await ctx.send(response_message)
                    self.log_message(f"RESPONSE | {response_message}")
            if permission_scene != 'owner':
                response_message = "Permission denied."
                await ctx.send(response_message)
                self.log_message(f"RESPONSE | {response_message}")
            return

        # Parse the content of the message to extract arguments
        arguments_chat = shlex.split(ctx.message.content)[1:]
        # Append custom static arguments to the list
        arguments_scene = ["-s", "brh", "-sc", "q"]
        # Combine parsed arguments and static arguments
        arguments = arguments_scene + arguments_chat
        # Construct the command to run the script with combined arguments
        script_path = "./configurator.sh"
        command = [script_path] + arguments
        # Print the constructed command for debugging purposes
        self.log_message("EXECUTE  | " + ' '.join(command))
        # Execute the command
        subprocess.run(command)

    def load_permissions(self):
        # Load permissions from separate files
        self.user_permissions = {}

        # Iterate over each permission level
        for level, _ in self.permission_levels.items():
            file_path = f"/media/storage/Streaming/Software/data/role_{level}_list.txt"
            if os.path.exists(file_path):
                with open(file_path, "r") as file:
                    for line in file:
                        username = line.strip()
                        self.user_permissions[username] = self.permission_levels[level]

    def get_permission_level(self, username):
        # Get permission level of the user
        return self.user_permissions.get(username, 0)

bot = Bot()
bot.run()
