import os
import subprocess
import time

home_path = os.path.expanduser("~")
player_path = os.path.join(home_path, 'mpv', 'mpv.exe')
streamlink = (
    f"streamlink --twitch-low-latency twitch.tv/reality_hurts 480p "
    f"--player \"{player_path}\" "
    f"--player-args \"--no-cache --osc=no --stop-screensaver=no --input-test --no-config --ontop --border=no --geometry=0:0 --autofit-smaller=2000\""
)

while True:
    while True:
        try:
            result = subprocess.run(streamlink, capture_output=True, text=True, check=True, shell=True)
            print("STDOUT:")
            print(result.stdout)
        except subprocess.CalledProcessError as e:
            print(f"An error occurred: {e}")
            print("STDERR:")
            print(e.stderr)
            time.sleep(5)
    time.sleep(5)