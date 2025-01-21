# your path gets massive and fish becomes very slow.
set -e fish_user_paths
set -U fish_user_paths $HOME/.bin  $HOME/.local/bin $HOME/.config/emacs/bin $HOME/go/bin $fish_user_paths

set TERM "xterm-256color"                         # Sets the terminal type


# Generated for envman. Do not edit.
test -s ~/.config/envman/load.fish; and source ~/.config/envman/load.fish
