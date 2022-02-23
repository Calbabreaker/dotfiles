import subprocess
import os
from libqtile import bar, hook, layout, widget
from libqtile.config import Click, Drag, Group, Key, Match, Screen
from libqtile.lazy import lazy

# programs
terminal = "alacritty"
file_manager = "pcmanfm"
browser = "brave"
launcher = "dmenu_run -nb '#21262e' -fn 'SauceCodePro Nerd Font:size=10' -i -p 'Run: '"

@lazy.function
def kill_all_windows(qtile):
	for window in qtile.current_group.windows:
		window.kill()

def wrap(value,start, end):
    if value > end:
        return start;
    elif value < start:
        return end;
    else: 
        return value;

# NOTE: for this to work groups must be an ordered number set
@lazy.function
def window_to_offset_group(qtile, offset, switch_group=True):
    if qtile.current_window:
        i = wrap(int(qtile.current_group.name) + offset, 1, len(qtile.groups))
        qtile.current_window.togroup(str(i), switch_group=switch_group)

@lazy.function
def window_to_offset_screen(qtile, offset, switch_screen=True):
    if qtile.current_window:
        i = wrap(qtile.current_screen.index + offset, 0, len(qtile.screens) - 1)
        group = qtile.screens[i].group.name
        qtile.current_window.togroup(group)
        if switch_screen == True:
            qtile.cmd_to_screen(i)

show_brightness_cmd = 'value=$(xbacklight -get | cut -d. -f1) && dunstify -t 2000 -u low -r 13481 -h int:value:$value "Brightness: $value" --icon a'

mod = "mod4" # super key
keys = [
    # A list of available commands that can be bound to keys can be found
    # at https://docs.qtile.org/en/latest/manual/config/lazy.html
    Key([mod], "r", lazy.restart(), desc="Reload config"),
    Key([mod, "shift"], "r", lazy.restart(), desc="Restart Qtile"),
    Key([mod, "shift"], "q", lazy.shutdown(), desc="Quit Qtile"),
    Key([mod, "control", "shift"], "q", lazy.spawn("shutdown now"), desc="Shutdown computer"),
    Key([mod, "control", "shift"], "s", lazy.spawn("systemctl suspend"), desc="Sleep/suspend computer"),
    Key([mod, "control", "shift"], "r", lazy.spawn("reboot"), desc="Reboot computer"),

    Key([mod], "Return", lazy.spawn(terminal), desc="Launch terminal"),
    Key([mod, "shift"], "Return", lazy.spawn(launcher), desc="Show program launcher"),
    Key([mod], "b", lazy.spawn(browser), desc="Launch browser"),
    Key([mod], "e", lazy.spawn(file_manager), desc="Launch file manager"),
    Key([mod, "control"], "l", lazy.spawn("xset s activate"), desc="Lock computer with lock screen"),

    Key([mod], "c", lazy.window.kill(), desc="Kill focused window"),
    Key([mod, "shift"], "c", kill_all_windows, desc="Kill all windows in group"),

    # Switch between windows
    Key([mod], "j", lazy.layout.down(), desc="Move focus down"),
    Key([mod], "k", lazy.layout.up(), desc="Move focus up"),
    Key([mod], "plus", lazy.layout.increase_ratio(), desc="Increase number of master windows"),
    Key([mod], "minus", lazy.layout.decrease_ratio(), desc="Decrease number of master windows"),
    Key(["mod1"], "Tab", lazy.layout.next(), desc="Move window focus to other window"),
    Key([mod], "m", lazy.layout.swap_main(), desc="Promote to master"),

    Key([mod], "comma", lazy.screen.prev_group(), desc="Go to next group"),
    Key([mod], "period", lazy.screen.next_group(), desc="Go to next group"),
    Key([mod], "BackSpace", lazy.screen.toggle_group(), desc="Go to previous group"),
    Key([mod, "shift"], "comma", window_to_offset_group(-1), desc="Move window and go to prev group"),
    Key([mod, "shift"], "period", window_to_offset_group(1), desc="Move window and go to next group"),
    Key([mod, "control", "shift"], "comma", window_to_offset_group(-1, False), desc="Move window to prev group"),
    Key([mod, "control", "shift"], "period", window_to_offset_group(1, False), desc="Move window to next group"),
    Key([mod, "mod1"], "comma", lazy.prev_screen(), desc="Go to prev screen"),
    Key([mod, "mod1"], "period", lazy.next_screen(), desc="Go to next screen"),
    Key([mod, "shift", "mod1"], "comma", window_to_offset_screen(-1), desc="Move window and to prev screen"),
    Key([mod, "shift", "mod1"], "period", window_to_offset_screen(1), desc="Move window and to next screen"),
    Key([mod, "control", "shift", "mod1"], "comma", window_to_offset_screen(-1, False), desc="Move window to prev screen"),
    Key([mod, "control", "shift", "mod1"], "period", window_to_offset_screen(1, False), desc="Move window to next screen"),

    Key([mod, "shift"], "h", lazy.layout.shuffle_left(), desc="Move window left"),
    Key([mod, "shift"], "l", lazy.layout.shuffle_right(), desc="Move window right"),
    Key([mod, "shift"], "j", lazy.layout.shuffle_down(), desc="Move window down"),
    Key([mod, "shift"], "k", lazy.layout.shuffle_up(), desc="Move window up"),
    Key([mod], "l", lazy.layout.grow_main(), desc="Grow window"),
    Key([mod], "h", lazy.layout.shrink_main(), desc="Shrink window"),

    Key([mod], "n", lazy.layout.normalize(), desc="Reset all window sizes"),
    Key([mod], "space", lazy.next_layout(), desc="Toggle between layouts"),
    Key([mod, "shift"], "space", lazy.hide_show_bar("top"), desc="Toggle bar"),
    Key([mod], "f", lazy.window.toggle_floating(), desc="Toggle floating"),
    Key([mod, "shift"], "f", lazy.window.toggle_fullscreen(), desc="Toggle fullscreen"),
    Key([], "F11", lazy.window.toggle_fullscreen(), desc="Toggle fullscreen"),

    Key([mod, "shift"], "Up", lazy.spawn("xrandr --output eDP1 --rotate normal"), desc="Rotate screen normal"),
    Key([mod, "shift"], "Down", lazy.spawn("xrandr --output eDP1 --rotate inverted"), desc="Rotate screen normal"),
    Key([mod, "shift"], "Left", lazy.spawn("xrandr --output eDP1 --rotate left"), desc="Rotate screen normal"),
    Key([mod, "shift"], "Right", lazy.spawn("xrandr --output eDP1 --rotate right"), desc="Rotate screen normal"),

    # Media keys
    Key([], "XF86AudioPlay", lazy.spawn("playerctl play-pause")),
    Key([], "XF86AudioPrev", lazy.spawn("playerctl previous")),
    Key([], "XF86AudioNext", lazy.spawn("playerctl next")),
    Key([], "XF86MonBrightnessUp", lazy.spawn(f"bash -c 'xbacklight -inc 5% && {show_brightness_cmd}'")),
    Key([], "XF86MonBrightnessDown", lazy.spawn(f"bash -c 'xbacklight -dec 5% && {show_brightness_cmd}'")),
]

groups = [Group(name) for name in "123456789"]

for i, group in enumerate(groups):
    i += 1
    keys += [
        # mod + number of group = switch to group
        Key([mod], str(i), lazy.group[group.name].toscreen(),
            desc=f"Switch to group {i}"),

        # mod + shift + number of group = switch to & move focused window to group
        Key([mod, "shift"], str(i), lazy.window.togroup(group.name, switch_group=True),
            desc=f"Switch to and move focused window to group {i}"),

        # # mod + control + shift + number of group = move focused window to group
        Key([mod, "control", "shift"], str(i), lazy.window.togroup(group.name),
            desc=f"Move focused window to group {i}"),
    ]

# Drag floating layouts.
mouse = [
    Drag([mod], "Button1", lazy.window.set_position_floating(), start=lazy.window.get_position()),
    Drag([mod], "Button3", lazy.window.set_size_floating(), start=lazy.window.get_size()),
    Click([mod], "Button2", lazy.window.bring_to_front())
]

layout_theme = {
    "border_width": 2,
    "margin": 8,
    "border_focus": "#668bd7",
    "border_normal": "#1d2330",
    # "single_border_width": 0,
    # "single_margin": 0,
}

layouts = [
    layout.MonadTall(**layout_theme),
    layout.MonadWide(**layout_theme),
    layout.RatioTile(**layout_theme),
    layout.Max(**layout_theme),
    layout.TreeTab(**layout_theme),
    # Try more layouts by unleashing layouts below.
    # layout.Stack(num_stacks=2),
    # layout.Bsp(),
    # layout.Matrix(),
    # layout.RatioTile(),
    # layout.Tile(),
    # layout.VerticalTile(),
    # layout.Zoomy(),
]

widget_defaults = {
    "font": "Helvetica",
    "fontsize": 12,
    "padding": 5,
    "background": "#21262e",
    "foreground": "#dfdfdf"
}

mono_font = "SauceCodePro NerdFont"

widgets = [
    # See https://docs.qtile.org/en/latest/manual/ref/widgets.html for list of widgets
    widget.CurrentLayoutIcon(
        scale = 0.7,
        padding = 0,
    ),
    widget.GroupBox(
        highlight_method = "line", 
        borderwidth = 2,
        inactive="#6e6e6e",
        highlight_color="#303743",
        disable_drag=True,
        font = mono_font,
    ),
    widget.WindowName(),
    widget.CPU(
        format="🖥 {load_percent}%",
        mouse_callbacks = {"Button1": lazy.spawn(terminal + " -e btop")},
    ),
    widget.ThermalSensor(
        fmt = "🌡{}",
        foreground = widget_defaults["foreground"],
        mouse_callbacks = {"Button1": lazy.spawn(terminal + " -e btop")},
    ),
    widget.Memory(
        format="🧠 {MemPercent}% {MemUsed:.0f}M",         
        mouse_callbacks = {"Button1": lazy.spawn(terminal + " -e btop")}
    ),
    widget.Net(format = '🌐{down}⬇{up}⬆'),
]

has_battery = os.path.exists("/sys/class/power_supply/BAT0/status")
if has_battery: 
    widgets += widget.Battery(
        update_interval=10,
        discharge_char="",
        charge_char="+",
        notify_below=10, 
        format="🔋{char}{percent:2.0%} {hour:d}:{min:02d}",
        background=widget_defaults["background"],
    ),

widgets += [
    widget.CheckUpdates(
        update_interval = 1800,
        custom_command = "sudo pacman -Sy > /dev/null && pacman -Quq",
        display_format = "📦{updates} ",
        execute = terminal + " -e sudo pacman -Syu",
    ),
    widget.Clock(format="🕛 %H:%M %a %d %b"),
    widget.Spacer(8),
    widget.Systray(icons_size=16, padding = 0),
]

screens = [
    Screen(
        top=bar.Bar(
            widgets, 
            size=20,
            border_width=[0, 0, 1, 0],
            border_color="#3b4352",
        )
    ),
]

@hook.subscribe.startup_once
def autostart():
    home = os.path.expanduser("~")
    subprocess.run([home + "/.config/qtile/startup.sh"])

dgroups_key_binder = None
dgroups_app_rules = []
follow_mouse_focus = True
bring_front_click = False
cursor_warp = False
auto_fullscreen = True
focus_on_window_activation = "smart"
reconfigure_screens = True
floating_layout = layout.Floating(
    float_rules=[
        # Run the utility of `xprop` to see the wm class and name of an X client.
        *layout.Floating.default_float_rules,
        Match(wm_class="confirmreset"),  # gitk
        Match(wm_class="makebranch"),  # gitk
        Match(wm_class="maketag"),  # gitk
        Match(wm_class="ssh-askpass"),  # ssh-askpass
        Match(wm_class="pinentry-gtk-2"),  # GPG key password entry
        Match(wm_class="pinentry-gtk-3"),  # GPG key password entry
    ],
    **layout_theme, 
)

# If things like steam games want to auto-minimize themselves when losing
# focus, should we respect this or not?
auto_minimize = True

# We choose LG3D to maximize irony: it is a 3D non-reparenting WM written in
# java that happens to be on java's whitelist.
wmname = "LG3D"
