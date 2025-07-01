# Final Merged config.py
# Combines the dynamic theme (from the second file) with the useful shortcuts and functions (from the first file).

# --- Basic Setup & Boilerplate ---
# pylint: disable=C0111
c = c  # noqa: F821 pylint: disable=E0602,C0103
config = config  # noqa: F821 pylint: disable=E0602,C0103
import subprocess

# --- Function to read colors from Xresources (for pywal integration) ---
def read_xresources(prefix):
    """
    Reads color properties from Xresources.
    Returns a dictionary of colors.
    """
    props = {}
    try:
        x = subprocess.run(['xrdb', '-query'], capture_output=True, check=True, text=True)
        lines = x.stdout.split('\n')
        for line in filter(lambda l : l.startswith(prefix), lines):
            prop, _, value = line.partition(':\t')
            key = prop.split(':')[0]
            props[key] = value
    except (subprocess.CalledProcessError, FileNotFoundError):
        # Fallback to a safe color scheme (Gruvbox) if reading fails (e.g., on Wayland)
        return {
            "*.background": "#282828", "*.foreground": "#ebdbb2",
            "*.color0": "#282828", "*.color1": "#cc241d", "*.color2": "#98971a",
            "*.color3": "#d79921", "*.color4": "#458588", "*.color5": "#b16286",
            "*.color6": "#689d6a", "*.color7": "#a89984", "*.color8": "#928374",
            "*.color9": "#fb4934", "*.color10": "#b8bb26", "*.color11": "#fabd2f",
            "*.color12": "#83a598", "*.color13": "#d3869b", "*.color14": "#8ec07c",
            "*.color15": "#ebdbb2",
        }
    return props

xresources = read_xresources("*")

# --- Apply Dynamic Theme (from the second file) ---

# Status Bar
c.colors.statusbar.normal.bg = xresources["*.background"]
c.colors.statusbar.command.bg = xresources["*.background"]
c.colors.statusbar.normal.fg = xresources["*.foreground"]
c.colors.statusbar.command.fg = xresources["*.foreground"]
c.colors.statusbar.passthrough.fg = xresources["*.color14"]
c.colors.statusbar.url.fg = xresources["*.color13"]
c.colors.statusbar.url.success.https.fg = xresources["*.color10"]
c.colors.statusbar.url.hover.fg = xresources["*.color12"]

# Tabs
# Using transparency for a consistent look with transparent terminals. Requires a compositor like 'picom'.
c.colors.tabs.even.bg = "#00000000"
c.colors.tabs.odd.bg = "#00000000"
c.colors.tabs.bar.bg = "#00000000"
# If you don't use a compositor, uncomment the following lines:
# c.colors.tabs.even.bg = xresources["*.background"]
# c.colors.tabs.odd.bg = xresources["*.background"]
# c.colors.tabs.bar.bg = xresources["*.background"]

c.colors.tabs.even.fg = xresources["*.color8"]
c.colors.tabs.odd.fg = xresources["*.color8"]
c.colors.tabs.selected.even.bg = xresources["*.color12"]
c.colors.tabs.selected.odd.bg = xresources["*.color12"]
c.colors.tabs.selected.even.fg = xresources["*.background"]
c.colors.tabs.selected.odd.fg = xresources["*.background"]

# Completion Menu
c.colors.completion.fg = xresources["*.foreground"]
c.colors.completion.odd.bg = xresources["*.color0"]
c.colors.completion.even.bg = xresources["*.color0"]
c.colors.completion.category.fg = xresources["*.color11"]
c.colors.completion.category.bg = xresources["*.color0"]
c.colors.completion.item.selected.fg = xresources["*.foreground"]
c.colors.completion.item.selected.bg = xresources["*.color4"]
c.colors.completion.match.fg = xresources["*.color10"]

# Hints
c.colors.hints.bg = xresources["*.color3"]
c.colors.hints.fg = xresources["*.background"]
c.hints.border = "1px solid " + xresources["*.foreground"]


# --- Miscellaneous Settings (merged from both files) ---

# Do not load autoconfig.yml to avoid conflicts
config.load_autoconfig(False)

# Vim-like command aliases (from the first file)
c.aliases = {'q': 'quit', 'w': 'session-save', 'wq': 'quit --save'}

# Fonts (from the second file, with better Arabic support)
c.fonts.default_family = ["Noto Sans Arabic", "DejaVu Sans", "JetBrainsMono Nerd Font", "monospace"]
c.fonts.default_size = '11pt'
c.fonts.web.family.standard = "Noto Sans"
c.fonts.web.family.serif = "Noto Serif"
c.fonts.web.family.sans_serif = "Noto Sans"
c.fonts.web.family.fixed = "JetBrainsMono Nerd Font, monospace"
c.fonts.web.size.default = 18
c.fonts.web.size.default_fixed = 16

# Start and default pages (from the first file)
c.url.default_page = 'https://distro.tube/'
c.url.start_pages = 'https://distro.tube/'

# General Browser Behavior
c.auto_save.session = True
c.tabs.show = "multiple"
c.tabs.padding = {'top': 5, 'bottom': 5, 'left': 9, 'right': 9}
c.tabs.indicator.width = 1
c.tabs.width = '10%'
c.tabs.title.format = "{audio}{current_title}"
c.downloads.location.directory = '~/Downloads'

# Webpage Dark Mode (from the second file)
c.colors.webpage.darkmode.enabled = True
c.colors.webpage.darkmode.algorithm = 'lightness-cielab'
c.colors.webpage.darkmode.policy.images = 'never'
config.set('colors.webpage.darkmode.enabled', False, 'file://*') # Disable for local files

# Search Engines (merged list from both files)
c.url.searchengines = {
    'DEFAULT': 'https://duckduckgo.com/?q={}',
    'am': 'https://www.amazon.com/s?k={}',
    'aw': 'https://wiki.archlinux.org/?search={}',
    'goog': 'https://www.google.com/search?q={}',
    'hoog': 'https://hoogle.haskell.org/?hoogle={}',
    're': 'https://www.reddit.com/r/{}',
    'ub': 'https://www.urbandictionary.com/define.php?term={}',
    'wiki': 'https://en.wikipedia.org/wiki/{}',
    'yt': 'https://www.youtube.com/results?search_query={}',
    '!apkg': 'https://archlinux.org/packages/?sort=&q={}&maintainer=&flagged=',
    '!gh': 'https://github.com/search?o=desc&q={}&s=stars',
}
c.completion.open_categories = ['searchengines', 'quickmarks', 'bookmarks', 'history', 'filesystem']

# Privacy Settings (from the second file)
config.set("content.webgl", False, "*")
config.set("content.canvas_reading", False)
config.set("content.geolocation", False)
config.set("content.webrtc_ip_handling_policy", "default-public-interface-only")

# Adblocking
c.content.blocking.enabled = True
# c.content.blocking.method = 'adblock' # Uncomment if python-adblock is installed

# User Agent settings (added from the first file to ensure compatibility)
config.set('content.headers.user_agent', 'Mozilla/5.0 ({os_info}) AppleWebKit/{webkit_version} (KHTML, like Gecko) {upstream_browser_key}/{upstream_browser_version} Safari/{webkit_version}', 'https://web.whatsapp.com/')
config.set('content.headers.user_agent', 'Mozilla/5.0 ({os_info}; rv:71.0) Gecko/20100101 Firefox/71.0', 'https://accounts.google.com/*')
config.set('content.headers.user_agent', 'Mozilla/5.0 ({os_info}) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/99 Safari/537.36', 'https://*.slack.com/*')
config.set('content.headers.user_agent', 'Mozilla/5.0 ({os_info}; rv:71.0) Gecko/20100101 Firefox/71.0', 'https://docs.google.com/*')
config.set('content.headers.user_agent', 'Mozilla/5.0 ({os_info}; rv:71.0) Gecko/20100101 Firefox/71.0', 'https://drive.google.com/*')

# Allow notifications for specific sites (from the first file)
config.set('content.notifications.enabled', True, 'https://www.reddit.com')
config.set('content.notifications.enabled', True, 'https://www.youtube.com')
# --- Keybindings (merged from both files) ---
# Priority is given to the preferred keybindings from the first file.

# (NEW) Add current page to bookmarks (prompts for title)
config.bind('B', 'set-cmd-text -s :bookmark-add --title "{title}"')

# (Added from the first file) to play videos in mpv
config.bind('M', 'hint links spawn mpv {hint-url}')
# (Added from the first file) to download videos with youtube-dl
config.bind('Z', 'hint links spawn st -e youtube-dl {hint-url}')
# (Added from the first file) to open a new tab
config.bind('t', 'set-cmd-text -s :open -t')

# (From the second file)
config.bind('=', 'set-cmd-text -s :open')
config.bind('h', 'history')
config.bind('cs', 'config-source')
config.bind('tH', 'config-cycle tabs.show multiple never')
config.bind('sH', 'config-cycle statusbar.show always never')
config.bind('T', 'hint links tab-bg') # Using tab-bg to open the tab in the background
config.bind('pP', 'open -- {primary}')
config.bind('pp', 'open -- {clipboard}')
config.bind('pt', 'open -t -- {clipboard}')
config.bind('qm', 'macro-record')
config.bind('<ctrl-y>', 'spawn --userscript ytdl.sh') # Alternative for video download
config.bind('tT', 'config-cycle tabs.position top left')
config.bind('gJ', 'tab-move +')
config.bind('gK', 'tab-move -')
config.bind('gm', 'tab-move')

print("Custom merged config loaded successfully!")
