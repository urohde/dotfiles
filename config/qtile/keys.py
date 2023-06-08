from collections.abc import Callable
from libqtile.config import Key, KeyChord
from libqtile.lazy import lazy
from libqtile.utils import guess_terminal
from libqtile.config import Key

from groups import groups

mod = "mod4"
terminal = guess_terminal()
lockscreen = "betterlockscreen --off 15 -l"

def arrange_groups_default(qtile):
    qtile.groupMap["www"].cmd_toscreen(0)
    qtile.groupMap["term"].cmd_toscreen(3)
    qtile.groupMap["chat"].cmd_toscreen(1)

def arrange_groups_browser(qtile):
    qtile.groupMap["www"].cmd_toscreen(0)
    qtile.groupMap["term"].cmd_toscreen(1)
    qtile.groupMap["chat"].cmd_toscreen(2)

keys = [
    # Switch between windows
    Key([mod], "h", lazy.layout.left(), desc="Move focus to left"),
    Key([mod], "l", lazy.layout.right(), desc="Move focus to right"),
    Key([mod], "j", lazy.layout.down(), desc="Move focus down"),
    Key([mod], "k", lazy.layout.up(), desc="Move focus up"),
    Key([mod], "space", lazy.layout.next(), desc="Move window focus to other window"),
    Key([mod], "f", lazy.window.toggle_fullscreen(), desc="Toggle fullscreen"),

    # Moving out of range in Columns layout will create new column.
    Key([mod, "shift"], "h", lazy.layout.shuffle_left(), desc="Move window to the left"),
    Key([mod, "shift"], "l", lazy.layout.shuffle_right(), desc="Move window to the right"),
    Key([mod, "shift"], "j", lazy.layout.shuffle_down(), desc="Move window down"),
    Key([mod, "shift"], "k", lazy.layout.shuffle_up(), desc="Move window up"),

    # Grow windows
    Key([mod, "control"], "h", lazy.layout.grow_left(), desc="Grow window to the left"),
    Key([mod, "control"], "l", lazy.layout.grow_right(), desc="Grow window to the right"),
    Key([mod, "control"], "j", lazy.layout.grow_down(), desc="Grow window down"),
    Key([mod, "control"], "k", lazy.layout.grow_up(), desc="Grow window up"),
    Key([mod], "n", lazy.layout.normalize(), desc="Reset all window sizes"),

    Key([mod], "Tab", lazy.next_layout(), desc="Toggle between layouts"),
    Key([mod], "w", lazy.window.kill(), desc="Kill focused window"),

    Key([mod, "control"], "r", lazy.reload_config(), desc="Reload the config"),
    Key([mod, "control"], "q", lazy.shutdown(), desc="Shutdown Qtile"),
    KeyChord([], "pause", [
        Key([], "pause", lazy.spawn(lockscreen), desc="Lock screen")
        ]),

    Key([mod], "Return", lazy.spawn(terminal), desc="Launch terminal"),
    Key([mod, "shift"], "r", lazy.spawn("rofi -show run"), desc="Run script using rofi"),
    Key([mod], "r", lazy.spawn("rofi -show drun"), desc="Open application using rofi"),

    Key([mod], "F1", lazy.function(arrange_groups_default)),
    Key([mod], "F2", lazy.function(arrange_groups_browser)),

    Key([], "Print", lazy.spawn("flameshot gui")),
    Key(["shift"], "Print", lazy.spawn("flameshot full --clipboard")),

    Key([], "XF86AudioLowerVolume", lazy.spawn("amixer set Master 5%- unmute")),
    Key([], "XF86AudioRaiseVolume", lazy.spawn("amixer set Master 5%+ unmute")),
    Key([], "XF86AudioMute", lazy.spawn("amixer set Master togglemute")),
    Key([], "XF86AudioMicMute", lazy.spawn("amixer set Capture togglemute")),
    Key([], "XF86MonBrightnessDown", lazy.spawn("xbacklight -5")),
    Key([], "XF86MonBrightnessUp", lazy.spawn("xbacklight +5")),
]

def go_to_group(name: str) -> Callable:
    def _inner(qtile) -> None:
        if len(qtile.screens) == 1:
            qtile.groups_map[name].cmd_toscreen()
            return

        if name in '14':
            qtile.focus_screen(2)
            qtile.groups_map[name].cmd_toscreen()
        elif name in '3':
            qtile.focus_screen(1)
            qtile.groups_map[name].cmd_toscreen()
        else:
            qtile.focus_screen(0)
            qtile.groups_map[name].cmd_toscreen()

    return _inner

for index, i in enumerate(groups):
    keys.extend(
        [
            Key([mod], i.name, lazy.function(go_to_group(i.name))),
            Key([mod, "shift"], i.name, lazy.window.togroup(i.name),
                desc="Move focused window to group {}".format(i.label)),
        ]
    )

