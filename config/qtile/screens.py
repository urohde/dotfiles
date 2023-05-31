from libqtile.config import Screen
import subprocess
from bars import main_bar


monitors = int(subprocess.run("xrandr | grep ' connected '| wc -l", capture_output=True, shell=True).stdout.decode()[0])

if monitors == 2: 
    screens = [
            Screen( top=main_bar ),
            Screen(),
            ]
else: 
    screens = [
            Screen( top = main_bar)
            ]
