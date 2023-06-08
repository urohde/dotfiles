from libqtile import bar, widget

separator = widget.Sep(padding=4, linewidth=2)

main_bar = bar.Bar(
        [
            widget.CurrentLayoutIcon(scale=0.7),
            widget.GroupBox(highlight_method="block", font="MesloLGS NF"),
            widget.Prompt(),
            widget.WindowName(),
            widget.Systray(padding=6),
            separator,
            widget.Volume(fmt=" {}", font="MesloLGS NF"),
            separator,
            widget.Clock(format="%d.%m.%Y %a %H:%M"),
            widget.QuickExit(),
            ],
        24,
        )

