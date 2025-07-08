import os
from libqtile.extension import Dmenu
import libqtile.resources
from libqtile import bar, layout, qtile, widget
from libqtile.config import Click, Drag, Group, Key, Match, Screen
from libqtile.lazy import lazy
from libqtile.utils import guess_terminal

# Tokyo Night color palette
tokyo = {
    "bg": "#1a1b26",
    "fg": "#c0caf5",
    "black": "#1a1b26",
    "red": "#f7768e",
    "green": "#9ece6a",
    "yellow": "#e0af68",
    "blue": "#7aa2f7",
    "magenta": "#bb9af7",
    "cyan": "#7dcfff",
    "white": "#a9b1d6",
    "bright_black": "#414868",
    "bright_white": "#bac2de",
}

mod = "mod4"
terminal = guess_terminal()
dmenu = "dmenu_run"

# Key bindings
keys = [
    Key([mod], "d", lazy.spawn("j4-dmenu-desktop "),desc="Dmenu"),    
    Key([mod], "h", lazy.layout.left(), desc="Move focus to left"),
    Key([mod], "l", lazy.layout.right(), desc="Move focus to right"),
    Key([mod], "j", lazy.layout.down(), desc="Move focus down"),
    Key([mod], "k", lazy.layout.up(), desc="Move focus up"),
    Key([mod], "space", lazy.layout.next(), desc="Move window focus to next window"),
    Key([mod, "shift"], "h", lazy.layout.shuffle_left(), desc="Move window to the left"),
    Key([mod, "shift"], "l", lazy.layout.shuffle_right(), desc="Move window to the right"),
    Key([mod, "shift"], "j", lazy.layout.shuffle_down(), desc="Move window down"),
    Key([mod, "shift"], "k", lazy.layout.shuffle_up(), desc="Move window up"),
    Key([mod, "control"], "h", lazy.layout.grow_left(), desc="Grow window to the left"),
    Key([mod, "control"], "l", lazy.layout.grow_right(), desc="Grow window to the right"),
    Key([mod, "control"], "j", lazy.layout.grow_down(), desc="Grow window down"),
    Key([mod, "control"], "k", lazy.layout.grow_up(), desc="Grow window up"),
    Key([mod], "n", lazy.layout.normalize(), desc="Reset all window sizes"),
    Key([mod, "shift"], "Return", lazy.layout.toggle_split(), desc="Toggle split/stack mode"),
    Key([mod], "Return", lazy.spawn(terminal), desc="Launch terminal"),
    Key([mod], "Tab", lazy.next_layout(), desc="Toggle between layouts"),
    Key([mod], "q", lazy.window.kill(), desc="Kill focused window"),
    Key([mod], "f", lazy.window.toggle_fullscreen(), desc="Toggle fullscreen"),
    Key([mod], "t", lazy.window.toggle_floating(), desc="Toggle floating"),
    Key([mod, "shift"], "r", lazy.reload_config(), desc="Reload the config"),
    Key([mod, "control"], "q", lazy.shutdown(), desc="Shutdown Qtile"),
    Key([mod], "r", lazy.spawncmd(), desc="Spawn command prompt"),
      # Brightness controls
    Key([mod], "XF86MonBrightnessUp", lazy.spawn("brightnessctl set +10%")),
    Key([mod], "XF86MonBrightnessDown", lazy.spawn("brightnessctl set 10%-")),

    # Screenshot with maim and xclip
    Key([], "Print", lazy.spawn('sh -c "maim -s -u | xclip -selection clipboard -t image/png -i"')),
    # Pause mpv with mod+p
    Key([mod], "p", lazy.spawn("sh ~/.config/mpv/pause")),
]

keys += [
    Key([], "XF86AudioRaiseVolume", lazy.spawn("pactl set-sink-volume @DEFAULT_SINK@ +10%")),
    Key([], "XF86AudioLowerVolume", lazy.spawn("pactl set-sink-volume @DEFAULT_SINK@ -10%")),
    Key([], "XF86AudioMute", lazy.spawn("pactl set-sink-mute @DEFAULT_SINK@ toggle")),
    Key([], "XF86AudioMicMute", lazy.spawn("pactl set-source-mute @DEFAULT_SOURCE@ toggle")),
]
# VT switching on Wayland
for vt in range(1, 8):
    keys.append(
        Key(
            ["control", "mod1"],
            f"f{vt}",
            lazy.core.change_vt(vt).when(func=lambda: qtile.core.name == "wayland"),
            desc=f"Switch to VT{vt}",
        )
    )

# Groups (workspaces)
groups = [Group(i) for i in "123456789"]
for i in groups:
    keys.extend([
        Key([mod], i.name, lazy.group[i.name].toscreen(), desc=f"Switch to group {i.name}"),
        Key([mod, "shift"], i.name, lazy.window.togroup(i.name, switch_group=True), desc=f"Move window to group {i.name}"),
    ])

# Layouts with Tokyo Night borders
layouts = [
    layout.Max(
        border_focus=tokyo["green"],
        border_normal=tokyo["bright_black"],
        border_width=2,
        margin=5,
    ),
    layout.Columns(
        border_focus_stack=[tokyo["blue"], tokyo["magenta"]],
        border_focus=tokyo["cyan"],
        border_normal=tokyo["bright_black"],
        border_width=4,
        num_columns=4,
        grow_amount=10,
    ),
]

# Widget defaults
widget_defaults = dict(
    font="sans",
    fontsize=12,
    padding=3,
    foreground=tokyo["fg"],
    background=tokyo["bg"],
)
extension_defaults = widget_defaults.copy()

# Screens & bar
logo = os.path.join(os.path.dirname(libqtile.resources.__file__), "logo.png")
screens = [
    Screen(
        top=bar.Bar(
            [
                widget.CurrentLayout(),
                widget.GroupBox(
                    disable_drag=True,
                    highlight_method="block",
                    active=tokyo["blue"],
                    inactive=tokyo["bright_black"],
                    this_current_screen_border=tokyo["cyan"],
                    this_screen_border=tokyo["bright_black"],
                    use_mouse_wheel=False,
                ),
                widget.Prompt(),
                widget.WindowName(padding=5),
                widget.Systray(),
                widget.Clock(format="%Y-%m-%d %a %I:%M %p"),
                widget.QuickExit(),
            ],
            24,
            background=tokyo["bg"],
            margin=[2, 0, 2, 0],
        ),
        wallpaper=logo,
        wallpaper_mode="center",
    ),
]

# Mouse behavior
mouse = [
    Drag([mod], "Button1", lazy.window.set_position_floating(), start=lazy.window.get_position()),
    Drag([mod], "Button3", lazy.window.set_size_floating(), start=lazy.window.get_size()),
    Click([mod], "Button2", lazy.window.bring_to_front()),
]

# Other settings
dgroups_key_binder = None
dgroups_app_rules = []
follow_mouse_focus = True
bring_front_click = False
floats_kept_above = True
cursor_warp = False
floating_layout = layout.Floating(
    float_rules=[*layout.Floating.default_float_rules, Match(wm_class="confirmreset"), Match(wm_class="ssh-askpass")]
)
auto_fullscreen = True
focus_on_window_activation = "smart"
focus_previous_on_window_remove = False
reconfigure_screens = True
auto_minimize = True
wl_input_rules = None
wl_xcursor_theme = None
wl_xcursor_size = 24
wmname = "LG3D"
