import os
from libqtile.extension import Dmenu
import libqtile.resources
from libqtile import bar, layout, qtile, widget, hook
from libqtile.config import Click, Drag, Group, Key, Match, Screen
from libqtile.lazy import lazy
from libqtile.utils import guess_terminal
from tabbed import Tabbed
from qtile_bonsai import Bonsai
from qtile_bonsai import BonsaiBar
from libqtile.config import EzKey, KeyChord

groups = [
    Group("1"),
    Group("2"),
    Group("3"),
    Group("4"),
]

# Make sure workspace 4 is defined
groups.append(Group("4"))


# Automatically move any new mpv window to workspace 4
@hook.subscribe.client_new
def move_mpv_to_group(client):
    # Check if window class contains 'mpv'
    if client.window.get_wm_class() and "mpv" in client.window.get_wm_class():
        # Move the client to group "4"
        client.togroup("4")
        # Switch the screen focus to workspace 4 (index 3, zero-based)
        client.group.qtile.cmd_to_screen(3)


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
terminal = "kitty"
dmenu = "dmenu_run"
rofi_run_cmd = "rofi -show drun -m -1"
auto_fullscreen = True
# Key bindings
keys = [
    Key([mod], "d", lazy.spawn("j4-dmenu-desktop "), desc="Dmenu"),
    Key([mod], "h", lazy.layout.left(), desc="Move focus to left"),
    Key([mod], "l", lazy.layout.right(), desc="Move focus to right"),
    Key([mod], "j", lazy.layout.down(), desc="Move focus down"),
    Key([mod], "k", lazy.layout.up(), desc="Move focus up"),
    Key([mod], "space", lazy.layout.next(), desc="Move window focus to next window"),
    Key(
        [mod, "shift"], "h", lazy.layout.shuffle_left(), desc="Move window to the left"
    ),
    Key(
        [mod, "shift"],
        "l",
        lazy.layout.shuffle_right(),
        desc="Move window to the right",
    ),
    Key([mod, "shift"], "j", lazy.layout.shuffle_down(), desc="Move window down"),
    Key([mod, "shift"], "k", lazy.layout.shuffle_up(), desc="Move window up"),
    Key([mod, "control"], "h", lazy.layout.grow_left(), desc="Grow window to the left"),
    Key(
        [mod, "control"], "l", lazy.layout.grow_right(), desc="Grow window to the right"
    ),
    Key([mod, "control"], "j", lazy.layout.grow_down(), desc="Grow window down"),
    Key([mod, "control"], "k", lazy.layout.grow_up(), desc="Grow window up"),
    Key([mod], "n", lazy.layout.normalize(), desc="Reset all window sizes"),
    Key(
        [mod, "shift"],
        "Return",
        lazy.layout.toggle_split(),
        desc="Toggle split/stack mode",
    ),
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
    Key(
        [],
        "Print",
        lazy.spawn(
            "sh -c 'maim -s -u | tee \"$HOME/screenshots/$(date +%s).png\" | xclip -selection clipboard -t image/png'"
        ),
    ),
    # Pause mpv with mod+p
    Key([mod], "p", lazy.spawn("sh ~/.config/mpv/pause")),
]

keys += [
    Key(
        [],
        "XF86AudioRaiseVolume",
        lazy.spawn("pactl set-sink-volume @DEFAULT_SINK@ +10%"),
    ),
    Key(
        [],
        "XF86AudioLowerVolume",
        lazy.spawn("pactl set-sink-volume @DEFAULT_SINK@ -10%"),
    ),
    Key([], "XF86AudioMute", lazy.spawn("pactl set-sink-mute @DEFAULT_SINK@ toggle")),
    Key(
        [],
        "XF86AudioMicMute",
        lazy.spawn("pactl set-source-mute @DEFAULT_SOURCE@ toggle"),
    ),
]


# keys += [
#     # Open your terminal emulator quickly. See further below for how to
#     # directly open other apps as splits/tabs using something like rofi.
#     EzKey("M-v", lazy.layout.spawn_split(terminal, "x")),
#     EzKey("M-x", lazy.layout.spawn_split(terminal, "y")),
#     EzKey("M-t", lazy.layout.spawn_tab(terminal)),
#     EzKey("M-S-t", lazy.layout.spawn_tab(terminal, new_level=True)),
#     # Sometimes it's handy to have a split open in the 'previous' position
#     EzKey("M-S-v", lazy.layout.spawn_split(terminal, "x", position="previous")),
#     EzKey("M-S-x", lazy.layout.spawn_split(terminal, "y", position="previous")),
#     # Motions to move focus. The names are compatible with built-in layouts.
#     EzKey("M-h", lazy.layout.left()),
#     EzKey("M-l", lazy.layout.right()),
#     EzKey("M-k", lazy.layout.up()),
#     EzKey("M-j", lazy.layout.down()),
#     EzKey("M-d", lazy.layout.prev_tab()),
#     # EzKey("M-f", lazy.layout.next_tab()),
#     # Precise motions to move directly to specific tabs at the nearest tab level
#     EzKey("M-1", lazy.layout.focus_nth_tab(1, level=-1)),
#     EzKey("M-2", lazy.layout.focus_nth_tab(2, level=-1)),
#     EzKey("M-3", lazy.layout.focus_nth_tab(3, level=-1)),
#     EzKey("M-4", lazy.layout.focus_nth_tab(4, level=-1)),
#     EzKey("M-5", lazy.layout.focus_nth_tab(5, level=-1)),
#     # Precise motions to move to specific windows. The options provided here let
#     # us pick the nth window counting only from under currently active [sub]tabs
#     EzKey(
#         "C-1", lazy.layout.focus_nth_window(1, ignore_inactive_tabs_at_levels=[1, 2])
#     ),
#     EzKey(
#         "C-2", lazy.layout.focus_nth_window(2, ignore_inactive_tabs_at_levels=[1, 2])
#     ),
#     EzKey(
#         "C-3", lazy.layout.focus_nth_window(3, ignore_inactive_tabs_at_levels=[1, 2])
#     ),
#     EzKey(
#         "C-4", lazy.layout.focus_nth_window(4, ignore_inactive_tabs_at_levels=[1, 2])
#     ),
#     EzKey(
#         "C-5", lazy.layout.focus_nth_window(5, ignore_inactive_tabs_at_levels=[1, 2])
#     ),
#     # Resize operations
#     EzKey("M-C-h", lazy.layout.resize("left", 100)),
#     EzKey("M-C-l", lazy.layout.resize("right", 100)),
#     EzKey("M-C-k", lazy.layout.resize("up", 100)),
#     EzKey("M-C-j", lazy.layout.resize("down", 100)),
#     # Swap windows/tabs with neighbors
#     EzKey("M-S-h", lazy.layout.swap("left")),
#     EzKey("M-S-l", lazy.layout.swap("right")),
#     EzKey("M-S-k", lazy.layout.swap("up")),
#     EzKey("M-S-j", lazy.layout.swap("down")),
#     EzKey("A-S-d", lazy.layout.swap_tabs("previous")),
#     EzKey("A-S-f", lazy.layout.swap_tabs("next")),
#     # Manipulate selections after entering container-select mode
#     EzKey("M-o", lazy.layout.select_container_outer()),
#     EzKey("M-i", lazy.layout.select_container_inner()),
#     # It's kinda nice to have more advanced window management commands under a
#     # qtile key chord.
#     KeyChord(
#         ["mod4"],
#         "w",
#         [
#             # Use something like rofi to pick GUI apps to open as splits/tabs.
#             EzKey("v", lazy.layout.spawn_split(rofi_run_cmd, "x")),
#             EzKey("x", lazy.layout.spawn_split(rofi_run_cmd, "y")),
#             EzKey("t", lazy.layout.spawn_tab(rofi_run_cmd)),
#             EzKey("S-t", lazy.layout.spawn_tab(rofi_run_cmd, new_level=True)),
#             # Toggle container-selection mode to split/tab over containers of
#             # multiple windows. Manipulate using select_container_outer()/select_container_inner()
#             EzKey("C-v", lazy.layout.toggle_container_select_mode()),
#             EzKey("o", lazy.layout.pull_out()),
#             EzKey("u", lazy.layout.pull_out_to_tab()),
#             EzKey("r", lazy.layout.rename_tab()),
#             # Directional commands to merge windows with their neighbor into subtabs.
#             KeyChord(
#                 [],
#                 "m",
#                 [
#                     EzKey("h", lazy.layout.merge_to_subtab("left")),
#                     EzKey("l", lazy.layout.merge_to_subtab("right")),
#                     EzKey("j", lazy.layout.merge_to_subtab("down")),
#                     EzKey("k", lazy.layout.merge_to_subtab("up")),
#                     # Merge entire tabs with each other as splits
#                     EzKey("S-h", lazy.layout.merge_tabs("previous")),
#                     EzKey("S-l", lazy.layout.merge_tabs("next")),
#                 ],
#             ),
#             # Directional commands for push_in() to move window inside neighbor space.
#             KeyChord(
#                 [],
#                 "i",
#                 [
#                     EzKey("j", lazy.layout.push_in("down")),
#                     EzKey("k", lazy.layout.push_in("up")),
#                     EzKey("h", lazy.layout.push_in("left")),
#                     EzKey("l", lazy.layout.push_in("right")),
#                     # It's nice to be able to push directly into the deepest
#                     # neighbor node when desired. The default bindings above
#                     # will have us push into the largest neighbor container.
#                     EzKey(
#                         "S-j",
#                         lazy.layout.push_in("down", dest_selection="mru_deepest"),
#                     ),
#                     EzKey(
#                         "S-k",
#                         lazy.layout.push_in("up", dest_selection="mru_deepest"),
#                     ),
#                     EzKey(
#                         "S-h",
#                         lazy.layout.push_in("left", dest_selection="mru_deepest"),
#                     ),
#                     EzKey(
#                         "S-l",
#                         lazy.layout.push_in("right", dest_selection="mru_deepest"),
#                     ),
#                 ],
#             ),
#         ],
#     ),
# ]


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
    keys.extend(
        [
            Key(
                [mod],
                i.name,
                lazy.group[i.name].toscreen(),
                desc=f"Switch to group {i.name}",
            ),
            Key(
                [mod, "shift"],
                i.name,
                lazy.window.togroup(i.name, switch_group=True),
                desc=f"Move window to group {i.name}",
            ),
        ]
    )

# Layouts with Tokyo Night borders
layouts = [
    # layout.TreeTab(),
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
    Tabbed(),
    # Bonsai(
    #     **{
    #         # Specify your options here. These examples are defaults.
    #         "window.border_size": 1,
    #         "tab_bar.height": 20,
    #         # You can specify subtab level specific options if desired by prefixing
    #         # the option key with the appropriate level, eg. L1, L2, L3 etc.
    #         # For example, the following options affect only 2nd level subtabs and
    #         # their windows:
    #         # "L2.window.border_color": "#ff0000",
    #         # "L2.window.margin": 5,
    #     }
    # ),
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
                BonsaiBar(
                    **{
                        # "length": 500,
                        # "sync_with": "bonsai_on_same_screen",
                        # "tab.width": 50,
                        # ...
                    }
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
    Drag(
        [mod],
        "Button1",
        lazy.window.set_position_floating(),
        start=lazy.window.get_position(),
    ),
    Drag(
        [mod], "Button3", lazy.window.set_size_floating(), start=lazy.window.get_size()
    ),
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
    float_rules=[
        *layout.Floating.default_float_rules,
        Match(wm_class="confirmreset"),
        Match(wm_class="ssh-askpass"),
    ]
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
