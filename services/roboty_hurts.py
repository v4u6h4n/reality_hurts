import asyncio
import subprocess
import shlex
import logging
import threading
from logging.handlers import TimedRotatingFileHandler
from rgbprint import gradient_scroll, Color
import time
from datetime import datetime
from twitchio.ext import commands
import sys
import os

# Bot.

class Bot(commands.Bot):

    def __init__(self):
        self.refresh_access_token()
        super().__init__(token=self.get_access_token(), prefix='!', initial_channels=['reality_hurts'])
        self.setup_logging()

        # Define permission levels
        self.permission_levels = {
            'owner': 4,
            'leaseholder': 3,
            'roommate': 2,
            'housemate': 1,
            'couchsurfer': 0
        }

        # Load permissions from separate files
        self.load_permissions()

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
        # print ("Refreshing access token...")
        script_path = os.path.join(os.path.dirname(os.path.realpath(__file__)), '..', 'configurator.sh')
        subprocess.run([script_path, "--source", "roboty_hurts_owner", "--verbose", "--stream", "refresh", "twitch", "roboty_hurts"])


    def get_access_token(self):
        print("Getting access token...")
        token_file = os.path.join(os.path.dirname(os.path.realpath(__file__)), '..', '..', '..', 'data', 'stream_twitch_roboty_hurts_access_token.txt')
        with open(token_file, "r") as file:
            return file.read().strip()


    async def event_ready(self):
        self.log_message(f'Logged in as {self.nick}')
        self.loop.create_task(self.run_refresh_access_token_periodically())


    async def event_message(self, message):
        if message.echo:
            return

        if message.content.startswith(self._prefix):
            log_message = f"COMMAND  | {message.author.name}: {message.content}"
        else:
            log_message = f"CHAT     | {message.author.name}: {message.content}"

        self.log_message(log_message)
        await self.handle_commands(message)

        
    async def run_refresh_access_token_periodically(self):
        while True:
            await asyncio.sleep(1800)
            self.refresh_access_token()


    @commands.command(aliases=['b'])
    async def banner(self, ctx: commands.Context, *, banner_message: str = None):
        permission_file = os.path.join(os.path.dirname(os.path.realpath(__file__)), '..', '..', '..', 'data', 'permission_banner.txt')
        with open(permission_file, "r") as file:
            permission_banner = file.read().strip()

        if self.get_permission_level(ctx.author.name) < self.permission_levels[permission_banner]:
            if permission_banner == 'owner':
                    response_message = "Banner command locked."
                    await ctx.send(response_message)
                    self.log_message(f"RESPONSE | {response_message}")
            if permission_banner != 'owner':
                response_message = "Permission denied."
                await ctx.send(response_message)
                self.log_message(f"RESPONSE | {response_message}")
            return

        banner_type = banner_message.split()[0]
        banner_types = ["normal", "alert"]
        
        if banner_type not in banner_types:
            response_message = "Invalid banner type."
            await ctx.send(response_message)
            self.log_message(f"RESPONSE | {response_message}")
            return
        elif banner_type in banner_types:
            banner_message = ' '.join(banner_message.split()[1:])

        if banner_message is None:
            banner_message = " "

        if len(banner_message) > 70:
            banner_message = banner_message[:70]
            banner_padding = ""
        elif len(banner_message) == 70:
            banner_padding = ""
        elif len(banner_message) < 69:
            banner_padding_amount = (70 - len(banner_message)) // 2
            banner_padding = " " * banner_padding_amount

        if hasattr(self, 'banner_task') and not self.banner_task.done():
            self.banner_task.cancel()

        async def animate_banner():
            while True:
                print("\033c", end="")
                sys.stdout.write("\x1b[?25l")
                sys.stdout.flush()
                if banner_type == 'normal':
                    gradient_scroll(
                        banner_padding + banner_message, 
                        start_color=0x4BBEE3, 
                        end_color=Color.medium_violet_red,
                        delay=0.05,
                        times=1
                    )
                elif banner_type == 'alert':
                    gradient_scroll(
                        banner_padding + banner_message, 
                        start_color="ff5349",
                        end_color="e32227",
                        delay=0.02,
                        times=1
                    )
                await asyncio.sleep(0.001)

        self.banner_task = asyncio.create_task(animate_banner())


    @commands.command(aliases=['info', 'guide', 'settings', 'options', 'h', 'commands', 'menu'])
    async def help(self, ctx: commands.Context):
        await ctx.send("Commands: v4u6h4n.github.io/reality_hurts/viewer_commands")


    @commands.command(aliases=['social', 'links', 'link', 'discord'])
    async def socials(self, ctx: commands.Context):
        await ctx.send("Rules: https://lnk.bio/reality_hurts")


    @commands.command(aliases=['r'])
    async def rules(self, ctx: commands.Context):
        await ctx.send("Rules: v4u6h4n.github.io/reality_hurts/rules")


    @commands.command(aliases=['a'])
    @commands.cooldown(1, 10, commands.Bucket.channel)
    async def activity(self, ctx: commands.Context):

        permission_file = os.path.join(os.path.dirname(os.path.realpath(__file__)), '..', '..', '..', 'data', 'permission_stream.txt')
        with open(permission_file, "r") as file:
            permission_scene = file.read().strip()

        if self.get_permission_level(ctx.author.name) < self.permission_levels[permission_scene]:
            if permission_scene == 'owner':
                    response_message = "Activity command locked."
                    await ctx.send(response_message)
                    self.log_message(f"RESPONSE | {response_message}")
            if permission_scene != 'owner':
                response_message = "Permission denied."
                await ctx.send(response_message)
                self.log_message(f"RESPONSE | {response_message}")
            return

        arguments_chat = shlex.split(ctx.message.content)[1:]

        number_arguments_chat = len(arguments_chat)

        if number_arguments_chat == 1 and arguments_chat[0] in ["admin", "chores", "chilling", "coding", "cooking_breakfast", "cooking_lunch", "cooking_dinner", "crafts", "dancing", "eating_breakfast", "eating_lunch", "eating_dinner", "fitness", "morning", "painting", "relationship", "sewing", "socialising", "therapy_informal", "waking_up"]:
                pass
        else:
            response_message = "Invalid command."
            await ctx.send(response_message)
            self.log_message(f"RESPONSE | {response_message}")
            return

        if self.get_permission_level(ctx.author.name) == 4:
            temp_source = "rb_h_o"
        elif self.get_permission_level(ctx.author.name) == 3:
            temp_source = "rb_h_l"
        elif self.get_permission_level(ctx.author.name) == 2:
            temp_source = "rb_h_r"
        elif self.get_permission_level(ctx.author.name) == 1:
            temp_source = "rb_h_h"
        elif self.get_permission_level(ctx.author.name) == 0:
            temp_source = "rb_h_c"

        arguments_scene = ["--source", temp_source, "--verbose", "--stream", "info", "twitch", "reality_hurts", "passive", "p"]

        arguments = arguments_scene + arguments_chat
        script_path = os.path.join(os.path.dirname(os.path.realpath(__file__)), '..', 'configurator.sh')
        command = [script_path] + arguments
        self.log_message("EXECUTE  | " + ' '.join(command))
        subprocess.run(command)


    @commands.command(aliases=['s'])
    @commands.cooldown(1, 2, commands.Bucket.channel)
    async def scene(self, ctx: commands.Context):
        permission_file = os.path.join(os.path.dirname(os.path.realpath(__file__)), '..', '..', '..', 'data', 'permission_scene.txt')
        with open(permission_file, "r") as file:
            permission_scene = file.read().strip()

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

        arguments_chat = shlex.split(ctx.message.content)[1:]

        number_arguments_chat = len(arguments_chat)

        if number_arguments_chat == 2 and arguments_chat[0] in ["a", "v"] and arguments_chat[1] in ["ba", "bathroom", "be", "bed", "d", "desk", "k", "kitchen", "s", "studio"]:
                pass
        elif number_arguments_chat == 4 and arguments_chat[0] in ["a", "v"] and arguments_chat[2] in ["a", "v"] and arguments_chat[1] in ["ba", "bathroom", "be", "bed", "d", "desk", "k", "kitchen", "s", "studio"] and arguments_chat[3] in ["ba", "bathroom", "be", "bed", "d", "desk", "k", "kitchen", "s", "studio"]:
                pass
        else:
            response_message = "Invalid command."
            await ctx.send(response_message)
            self.log_message(f"RESPONSE | {response_message}")
            return

        if self.get_permission_level(ctx.author.name) == 4:
            temp_source = "rb_h_o"
        elif self.get_permission_level(ctx.author.name) == 3:
            temp_source = "rb_h_l"
        elif self.get_permission_level(ctx.author.name) == 2:
            temp_source = "rb_h_r"
        elif self.get_permission_level(ctx.author.name) == 1:
            temp_source = "rb_h_h"
        elif self.get_permission_level(ctx.author.name) == 0:
            temp_source = "rb_h_c"

        # Append custom static arguments to the list
        arguments_scene = ["--source", temp_source, "--verbose", "--scene", "quad"]
        # Combine parsed arguments and static arguments
        arguments = arguments_scene + arguments_chat
        # Construct the command to run the script with combined arguments
        script_path = os.path.join(os.path.dirname(os.path.realpath(__file__)), '..', 'configurator.sh')
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
            file_path = os.path.join(os.path.dirname(os.path.realpath(__file__)), '..', '..', '..', 'data', f'role_{level}_list.txt')
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
