from libqtile.config import Screen
import subprocess
from bars import main_bar


monitors = int(subprocess.run("xrandr | grep ' connected '| wc -l", capture_output=True, shell=True).stdout.decode()[0])

screens = [Screen( top=main_bar )]

for i in range(monitors - 1):
    screens.append(Screen())

