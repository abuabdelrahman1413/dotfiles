# ==============================================================================
# Fish Shell Configuration
# ==============================================================================
# This file is sourced on every shell startup.
# Order of sections: Environment -> PATH -> Aliases & Functions -> Startup

# --- Environment Variables ---
# Set essential environment variables. For security, sensitive data like API
# keys should be managed via a secrets manager, not stored in plaintext here.

set TERM "xterm-256color"      # Sets the terminal type for compatibility
set -x OLLAMA_ORIGINS "app://obsidian.md*"

# WARNING: Storing secrets in plaintext is insecure.
# Consider using a secret manager or private universal variables.
# Example: set -U --local GOOGLE_API_KEY "your_key_here"
set -x GOOGLE_API_KEY 'AIzaSyD-eDpgu35LVH7gpFPtxLnkbqgUrnXGins'
set -x GOOGLE_CLOUD_PROJECT "869371682686"

# Tool-specific environment variables
set -x BUN_INSTALL "$HOME/.bun"
set -x ANDROID_HOME "$HOME/Android/Sdk"


# --- PATH Management ---
# Using `fish_add_path` is the recommended, idempotent way to manage the PATH.
fish_add_path --universal \
    $HOME/.bin \
    /usr/sbin \
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

# Tool-specific paths
fish_add_path --universal $BUN_INSTALL/bin
fish_add_path --universal "$ANDROID_HOME/emulator"
fish_add_path --universal "$ANDROID_HOME/platform-tools"


# --- Aliases and Functions ---
# Simple aliases for commands without arguments, and functions for commands
# that need arguments and autocompletion.

# -- Aliases (No arguments needed) --
alias upd='sudo nala update && sudo nala upgrade -y'
alias clean='sudo nala autoremove -y && sudo nala clean'
alias xmysql='sudo /opt/lampp/bin/mysql -u root -p'
alias php='sudo /opt/lampp/bin/php-8.2.4'

# -- Functions (For autocompletion with arguments) --

# Install package(s)
function inst
    sudo nala install -y $argv
end
complete -c inst -w nala

# Remove package(s)
function rmv
    sudo nala remove -y $argv
end
complete -c rmv -w nala

# Search for a package
function srch
    nala search $argv
end
complete -c srch -w nala


# --- Sourcing External Configurations ---
# Load configurations from other tools like envman.

# Generated for envman. Do not edit.
if test -s ~/.config/envman/load.fish
    source ~/.config/envman/load.fish
end


# --- Startup Commands ---
# Commands to run at the end of shell initialization.

fastfetch
