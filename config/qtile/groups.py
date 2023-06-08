
from libqtile.config import Group, Match

groups = [
    Group("1", label="web", matches=[Match(wm_class="google-chrome"), Match(wm_class="firefox")], spawn="google-chrome", persist=True),
    Group("2", label="term", spawn="alacritty", persist=True),
    Group("3", label="chat", matches=[Match(wm_class="slack")], spawn="slack", persist=True),
    Group("4"),
    Group("5"),
]

