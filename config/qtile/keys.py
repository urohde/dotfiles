from collections.abc import Callable
from libqtile.config import Key, KeyChord
from libqtile.lazy import lazy
from libqtile.utils import guess_terminal
from libqtile.config import Key

from groups import groups

super = "mod4"
alt = "mod1"
terminal = guess_terminal()
lockscreen = "betterlockscreen -l dim --off 30 -- -e -n"

def arrange_groups_default(qtile):
    qtile.groupMap["1"].cmd_toscreen(2)
    qtile.groupMap["2"].cmd_toscreen(0)
    qtile.groupMap["3"].cmd_toscreen(1)

def arrange_groups_browser(qtile):
    qtile.groupMap["1"].cmd_toscreen(0)
    qtile.groupMap["2"].cmd_toscreen(2)
    qtile.groupMap["3"].cmd_toscreen(1)

keys = [
    # Switch between windows
    Key([super], "h", lazy.layout.left(), desc="Move focus to left"),
    Key([super], "l", lazy.layout.right(), desc="Move focus to right"),
    Key([super], "j", lazy.layout.down(), desc="Move focus down"),
    Key([super], "k", lazy.layout.up(), desc="Move focus up"),
    Key([super], "space", lazy.layout.next(), desc="Move window focus to other window"),
    Key([super], "f", lazy.window.toggle_fullscreen(), desc="Toggle fullscreen"),

    # Moving out of range in Columns layout will create new column.
    Key([super, "shift"], "h", lazy.layout.shuffle_left(), desc="Move window to the left"),
    Key([super, "shift"], "l", lazy.layout.shuffle_right(), desc="Move window to the right"),
    Key([super, "shift"], "j", lazy.layout.shuffle_down(), desc="Move window down"),
    Key([super, "shift"], "k", lazy.layout.shuffle_up(), desc="Move window up"),

    # Grow windows
    Key([super, "control"], "h", lazy.layout.grow_left(), desc="Grow window to the left"),
    Key([super, "control"], "l", lazy.layout.grow_right(), desc="Grow window to the right"),
    Key([super, "control"], "j", lazy.layout.grow_down(), desc="Grow window down"),
    Key([super, "control"], "k", lazy.layout.grow_up(), desc="Grow window up"),
    Key([super], "n", lazy.layout.normalize(), desc="Reset all window sizes"),

    Key([super], "Tab", lazy.next_layout(), desc="Toggle between layouts"),
    Key([super], "w", lazy.window.kill(), desc="Kill focused window"),

    Key([super, "control"], "r", lazy.reload_config(), desc="Reload the config"),
    Key([super, "control"], "q", lazy.shutdown(), desc="Shutdown Qtile"),
    KeyChord([], "pause", [
        Key([], "pause", lazy.spawn(lockscreen), desc="Lock screen"),
        ]),
    Key([super], "Return", lazy.spawn(terminal), desc="Launch terminal"),
    Key([super, "shift"], "r", lazy.spawn("rofi -show run"), desc="Run script using rofi"),
    Key([super], "r", lazy.spawn("rofi -show drun"), desc="Open application using rofi"),

    Key([super, alt], "1", lazy.function(arrange_groups_default)),
    Key([super, alt], "2", lazy.function(arrange_groups_browser)),

    Key([], "Print", lazy.spawn("flameshot gui")),
    Key(["shift"], "Print", lazy.spawn("flameshot full --clipboard")),

    Key([], "XF86AudioLowerVolume", lazy.spawn("amixer -q -D pulse set Master 5%- unmute")),
    Key([], "XF86AudioRaiseVolume", lazy.spawn("amixer -q -D pulse set Master 5%+ unmute")),
    Key([], "XF86AudioMute", lazy.spawn("amixer -q -D pulse set Master togglemute")),
    Key([], "XF86AudioMicMute", lazy.spawn("amixer -q -D pulse set Capture togglemute")),
    Key([], "XF86MonBrightnessDown", lazy.spawn("xbacklight -5")),
    Key([], "XF86MonBrightnessUp", lazy.spawn("xbacklight +5")),
]

def go_to_group(name: str) -> Callable:
    def _inner(qtile) -> None:
        if len(qtile.screens) == 1:
            qtile.groups_map[name].cmd_toscreen()
            return

        if len(qtile.screens) == 2:
            if name in '1':
                qtile.focus_screen(1)
                qtile.groups_map[name].cmd_toscreen()
            else: 
                qtile.focus_screen(0)
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
            Key([super, alt], i.name, lazy.group[i.name].toscreen(), desc="Switch to group {}".format(i.name)),
            Key([super], i.name, lazy.function(go_to_group(i.name))),
            Key([super, "shift"], i.name, lazy.window.togroup(i.name),
                desc="Move focused window to group {}".format(i.label)),
        ]
    )

