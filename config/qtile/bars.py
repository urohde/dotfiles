from libqtile import bar, widget

main_bar = bar.Bar(
        [
            widget.CurrentLayoutIcon(scale=0.7),
            widget.GroupBox(),
            widget.Prompt(),
            widget.WindowName(),
            widget.Systray(),
            widget.Clock(format="%d-%m-%Y %a %H:%M"),
            widget.QuickExit(),
            ],
        24,
        )

