# Copyright (c) 2024 JustAGuyLinux

from libqtile import bar, layout, widget, hook, qtile, widget
from libqtile.config import Click, Drag, Group, Key, Match, Screen, KeyChord
from libqtile.lazy import lazy
from libqtile.utils import guess_terminal
import os
import subprocess
from hijri_date import hijri_day, hijri_month, hijri_year
from libqtile import hook
import colors
from qtile_extras import widget
from qtile_extras.widget.decorations import BorderDecoration
import subprocess
from libqtile.config import Click, Drag
subprocess.call(["numlockx", "off"])

# setup pomodoro
from libqtile.widget import Pomodoro
pomodoro = Pomodoro()
from libqtile.widget import countdown
countdown = countdown.Countdown()

@hook.subscribe.startup_once
def autostart():
    home = os.path.expanduser("~/.config/qtile/autostart.sh")
    subprocess.run([home])


# Allows you to input a name when adding treetab section.
@lazy.layout.function
def add_treetab_section(layout):
    prompt = qtile.widgets_map["prompt"]
    prompt.start_input("Section name: ", layout.cmd_add_section)


# A function for hide/show all the windows in a group
@lazy.function
def minimize_all(qtile):
    for win in qtile.current_group.windows:
        if hasattr(win, "toggle_minimize"):
            win.toggle_minimize()

@lazy.function
def minimize_one(qtile):
    win = qtile.current_window
    if hasattr(win, "toggle_minimize"):
        win.toggle_minimize()


# A function for toggling between MAX and MONADTALL layouts
@lazy.function
def maximize_by_switching_layout(qtile):
    current_layout_name = qtile.current_group.layout.name
    if current_layout_name == "monadtall":
        qtile.current_group.layout = "max"
    elif current_layout_name == "max":
        qtile.current_group.layout = "monadtall"


mod = "mod4"  # Sets mod key to SUPER/WINDOWS
myTerm = "alacritty"  # My terminal of choice
myBrowser = "brave-browser"  # My browser of choice
myEmacs = "emacsclient -c -a 'emacs' "  # The space at the end is IMPORTANT!
colors, backgroundColor, foregroundColor, workspaceColor, chordColor = colors.gruvbox_light()

mouse = [
    Drag([mod], "Button1", lazy.window.set_position_floating(),
        start=lazy.window.get_position()),
    Drag([mod], "Button3", lazy.window.set_size_floating(),
        start=lazy.window.get_size()),
    Click([mod], "Button2", lazy.window.bring_to_front())
]

keys = [
    Key([mod], "Return", lazy.spawn(myTerm), desc="Terminal"),
    Key([mod], "space", lazy.spawn("rofi -show drun"), desc="Run Launcher"),
    Key([mod], "w", lazy.spawn(myBrowser), desc="Web browser"),
    Key(
        [mod],
        "b",
        lazy.hide_show_bar(position="all"),
        desc="Toggles the bar to show/hide",
    ),
    Key([mod], "Tab", lazy.next_layout(), desc="Toggle between layouts"),
    Key([mod, "shift"], "c", lazy.window.kill(), desc="Kill focused window"),
    Key([mod, "shift"], "r", lazy.reload_config(), desc="Reload the config"),
    Key([mod, "shift"], "q", lazy.spawn("dm-logout -r"), desc='Logout menu'),
    # Switch between windows
    Key([mod], "h", lazy.layout.left(), desc="Move focus to left"),
    Key([mod], "l", lazy.layout.right(), desc="Move focus to right"),
    Key([mod], "j", lazy.layout.down(), desc="Move focus down"),
    Key([mod], "k", lazy.layout.up(), desc="Move focus up"),
    Key(
        [mod, "shift"],
        "Return",
        lazy.layout.next(),
        desc="Move window focus to other window",
    ),
    # screenshot area
    Key(
        [mod],
        "Print",
        lazy.spawn(
            "bash -c 'scrot -s ~/Pictures/screenshot_$(date +%Y%m%d_%H%M%S).jpg'"
        ),
        desc="Screenshot",
    ),
    # screenshot full
    Key(
        [mod, "shift"],
        "Print",
        lazy.spawn("bash -c 'scrot ~/Pictures/screenshot_$(date +%Y%m%d_%H%M%S).png'"),
        desc="Screenshot",
    ),
    # Move windows between left/right columns or move up/down in current stack.
    Key(
        [mod, "shift"],
        "h",
        lazy.layout.shuffle_left(),
        lazy.layout.move_left().when(layout=["treetab"]),
        desc="Move window to the left/move tab left in treetab",
    ),
    Key(
        [mod, "shift"],
        "l",
        lazy.layout.shuffle_right(),
        lazy.layout.move_right().when(layout=["treetab"]),
        desc="Move window to the right/move tab right in treetab",
    ),
    Key(
        [mod, "shift"],
        "j",
        lazy.layout.shuffle_down(),
        lazy.layout.section_down().when(layout=["treetab"]),
        desc="Move window down/move down a section in treetab",
    ),
    Key(
        [mod, "shift"],
        "k",
        lazy.layout.shuffle_up(),
        lazy.layout.section_up().when(layout=["treetab"]),
        desc="Move window up/move up a section in treetab",
    ),
    # Toggle between split and unsplit sides of stack.
    Key(
        [mod, "shift"],
        "space",
        lazy.layout.toggle_split(),
        desc="Toggle between split and unsplit sides of stack",
    ),
    # Treetab prompt
    Key(
        [mod, "shift"],
        "a",
        add_treetab_section,
        desc="Prompt to add new section in treetab",
    ),
    # Grow/shrink windows left/right.
    Key(
        [mod],
        "equal",
        lazy.layout.grow_left().when(layout=["bsp", "columns"]),
        lazy.layout.grow().when(layout=["monadtall", "monadwide"]),
        desc="Grow window to the left",
    ),
    Key(
        [mod],
        "minus",
        lazy.layout.grow_right().when(layout=["bsp", "columns"]),
        lazy.layout.shrink().when(layout=["monadtall", "monadwide"]),
        desc="Grow window to the right",
    ),
    # Grow windows up, down, left, right.
    Key([mod, "control"], "h", lazy.layout.grow_left(), desc="Grow window to the left"),
    Key(
        [mod, "control"], "l", lazy.layout.grow_right(), desc="Grow window to the right"
    ),
    Key([mod, "control"], "j", lazy.layout.grow_down(), desc="Grow window down"),
    Key([mod, "control"], "k", lazy.layout.grow_up(), desc="Grow window up"),
    Key([mod], "n", lazy.layout.normalize(), desc="Reset all window sizes"),
    Key([mod], "m", lazy.layout.maximize(), desc="Toggle between min and max sizes"),
    Key([mod], "t", lazy.window.toggle_floating(), desc="toggle floating"),
    Key(
        [mod],
        "f",
        maximize_by_switching_layout(),
        lazy.window.toggle_fullscreen(),
        desc="toggle fullscreen",
    ),
    Key(
        [mod, "shift"],
        "m",
        minimize_all(),
        desc="Toggle hide/show all windows on current group",
    ),
    # minimize one
    Key(
        [mod, "shift"],
        "n",
        minimize_one,
        desc="Toggle hide/show one window on current group",
    ),
    # Audio Volume
    Key([mod], "XF86AudioRaiseVolume", lazy.spawn("pamixer -i 2")),
    Key([mod], "XF86AudioLowerVolume", lazy.spawn("pamixer -d 2")),

    # Dmenu/rofi scripts launched using the key chord SUPER+p followed by 'key'
    KeyChord([mod], "p", [
        Key([], "h", lazy.spawn("dm-hub -r"), desc='List all dmscripts'),
        Key([], "a", lazy.spawn("dm-sounds -r"), desc='Choose ambient sound'),
        Key([], "b", lazy.spawn("dm-setbg -r"), desc='Set background'),
        Key([], "c", lazy.spawn("dtos-colorscheme -r"), desc='Choose color scheme'),
        Key([], "e", lazy.spawn("dm-confedit -r"), desc='Choose a config file to edit'),
        Key([], "i", lazy.spawn("dm-maim -r"), desc='Take a screenshot'),
        Key([], "k", lazy.spawn("dm-kill -r"), desc='Kill processes '),
        Key([], "m", lazy.spawn("dm-man -r"), desc='View manpages'),
        Key([], "n", lazy.spawn("dm-note -r"), desc='Store and copy notes'),
        Key([], "o", lazy.spawn("dm-bookman -r"), desc='Browser bookmarks'),
        Key([], "p", lazy.spawn("rofi-pass"), desc='Logout menu'),
        Key([], "q", lazy.spawn("dm-logout -r"), desc='Logout menu'),
        Key([], "r", lazy.spawn("dm-radio -r"), desc='Listen to online radio'),
        Key([], "s", lazy.spawn("dm-websearch -r"), desc='Search various engines'),
        Key([], "t", lazy.spawn("dm-translate -r"), desc='Translate text')
    ])
]
# end of keys

groups = []
group_names = [
    "1",
    "2",
    "3",
    "4",
    "5",
    "6",
    "7",
    "8",
    "9",
]

group_labels = [
    "1",
    "2",
    "3",
    "4",
    "5",
    "6",
    "7",
    "8",
    "9",
]

group_layouts = [
    "monadtall",
    "monadtall",
    "tile",
    "tile",
    "monadtall",
    "monadtall",
    "monadtall",
    "monadtall",
    "monadtall",
]

for i in range(len(group_names)):
    groups.append(
        Group(
            name=group_names[i],
            layout=group_layouts[i].lower(),
            label=group_labels[i],
        )
    )

for i in groups:
    keys.extend(
        [
            Key(
                [mod],
                i.name,
                lazy.group[i.name].toscreen(),
                desc="Switch to group {}".format(i.name),
            ),
            Key(
                [mod, "shift"],
                i.name,
                lazy.window.togroup(i.name, switch_group=False),
                desc="Move focused window to group {}".format(i.name),
            ),
        ]
    )

# Define layouts and layout themes
layout_theme = {
    "margin": 4,
    "border_width": 2,
    "border_focus": colors[3],
    "border_normal": colors[1],
}

layouts = [
    layout.MonadTall(**layout_theme),
    layout.Tile(
        shift_windows=True,
        border_width=0,
        margin=0,
        ratio=0.335,
    ),
    layout.Max(
        border_width=0,
        margin=0,
    ),
    layout.Floating(
        border_width=0,
        margin=0,
    ),
]

widget_defaults = dict(
    font="JetBrains Mono Nerd Font",
    background=colors[0],
    foreground=colors[2],
    fontsize=14,
    padding=5,
)
extension_defaults = widget_defaults.copy()
separator = widget.Sep(size_percent=50, foreground=colors[3], linewidth=1, padding=10)
spacer = widget.Sep(size_percent=50, foreground=colors[3], linewidth=0, padding=10)


screens = [
    Screen(
        top=bar.Bar(
            [
                widget.GroupBox(
                    disable_drag=True,
                    use_mouse_wheel=False,
                    active=colors[4],
                    inactive=colors[5],
                    highlight_method="line",
                    this_current_screen_border=colors[10],
                    hide_unused=False,
                    rounded=False,
                    urgent_alert_method="line",
                    urgent_text=colors[9],
                ),
                widget.TaskList(
                    icon_size=0,
                    foreground=colors[0],
                    background=colors[2],
                    borderwidth=0,
                    border=colors[6],
                    margin_y=-5,
                    padding=8,
                    highlight_method="block",
                    title_width_method="uniform",
                    urgent_alert_method="border",
                    urgent_border=colors[1],
                    rounded=False,
                    txt_floating="🗗 ",
                    txt_maximized="🗖 ",
                    txt_minimized="🗕 ",
                ),
                widget.TextBox(text="", foreground=colors[1]),
                widget.CPU(format="{load_percent:04}%", foreground=foregroundColor),
                separator,
                widget.TextBox(text="󰻠", foreground=colors[1]),
                widget.Memory(
                    format="{MemUsed: .0f}{mm}/{MemTotal: .0f}{mm}",
                    measure_mem="G",
                    foreground=foregroundColor,
                ),
                separator,
                widget.Clock(format="%a, %-d %b %Y", foreground=foregroundColor),
                widget.Clock(format="%-I:%M %p", foreground=foregroundColor),
                separator,
                widget.TextBox(
                    text=f"{hijri_day()}   {hijri_month()}   {hijri_year()}",
                    foreground=foregroundColor,
                ),
                separator,
                widget.Volume(
                    fmt="󰕾 {}",
                    mute_command="amixer -D pulse set Master toggle",
                    foreground=colors[4],
                ),
                separator,
                # pomodoro
                pomodoro,
                separator,
                # Countdown
                # countdown,
                # separator,
                # Battery
                widget.BatteryIcon(
                    foreground=colors[4],
                    low_foreground=colors[9],
                    charging_color=colors[4],
                    low_percentage=0.15,
                    update_delay=1,
                ),
                widget.Battery(
                    foreground=colors[4],
                    low_foreground=colors[9],
                    low_percentage=0.15,
                    update_delay=10,
                ),
                spacer,
                widget.CurrentLayoutIcon(
                    custom_icon_paths=["/home/mohammed/.config/qtile/icons/layouts"],
                    scale=0.5,
                    padding=0,
                ),
                widget.Systray(
                    padding=6,
                ),
                spacer,
            ],
            24,
        ),
    ),
]

# تم تفعيل الأوضاع
floating_layout = layout.Floating(
    float_rules=[
        Match(wm_class="confirm"),
        Match(wm_class="dialog"),
        Match(wm_class="download"),
        Match(wm_class="error"),
        Match(wm_class="file_progress"),
        Match(wm_class="notification"),
        Match(wm_class="splash"),
        Match(wm_class="toolbar"),
        Match(wm_class="steam"),
        Match(wm_class="synapse"),
        Match(wm_class="feh"),
        Match(wm_class="xeyes"),
        Match(wm_class="lxappearance"),
        Match(wm_class="qtcreator"),
    ]
)

# اضافة الإعدادات النهائية
dgroups_key_binder = None
dgroups_app_rules = []  # type: ignore
main = None
follow_mouse_focus = True
bring_front_click = False
cursor_warp = False
floating_layout = layout.Floating()
auto_fullscreen = True
focus_on_window_activation = "smart"
wmname = "Qtile"
