# --- PATH Management ---
# Clear existing user paths to prevent duplication and ensure a clean slate
set -e fish_user_paths

# Set universal user paths.
# Order matters: paths added earlier are searched first.
# These should be DIRECTORIES that contain executable files.
set -U fish_user_paths \
    $HOME/.bin \
    $HOME/.local/bin \
    $HOME/.config/emacs/bin \
    $HOME/go/bin \
    $HOME/.local/opt/go/bin \
    $HOME/.local/opt/flutter/bin \
    $HOME/.local/opt/node/bin \
    $HOME/.local/opt/postgres/bin \
    $HOME/.local/opt/fd-v10.2.0/bin \
    $HOME/.local/opt/shellcheck-v0.10.0/bin \
    $HOME/.local/opt/shfmt-v3.10.0/bin

# IMPORTANT: Do not include "$fish_user_paths" at the end of the `set -U fish_user_paths` line.
# set -U fish_user_paths automatically appends to the universal path variable.
# Adding "$fish_user_paths" again would try to interpret its *contents* as commands,
# leading to the "command not found" errors you saw.

# --- Tool-specific configurations ---

# Bun installation path
set --export BUN_INSTALL "$HOME/.bun"
set --export PATH $BUN_INSTALL/bin $PATH

# Set ANDROID_HOME and add Android SDK tools to PATH
set -x ANDROID_HOME "$HOME/Android/Sdk"
fish_add_path "$ANDROID_HOME/emulator" "$ANDROID_HOME/platform-tools"

# Generated for envman. Do not edit.
# Ensure envman is sourced after your primary PATH setup, as it might append more paths.
test -s ~/.config/envman/load.fish; and source ~/.config/envman/load.fish

# --- Aliases ---
alias xmysql='sudo /opt/lampp/bin/mysql -u root -p'
alias php='sudo /opt/lampp/bin/php-8.2.4'

# --- Environment Variables ---
set TERM "xterm-256color" # Sets the terminal type
set -x OLLAMA_ORIGINS "app://obsidian.md*"


set -x GOOGLE_API_KEY 'AIzaSyD-eDpgu35LVH7gpFPtxLnkbqgUrnXGins'
