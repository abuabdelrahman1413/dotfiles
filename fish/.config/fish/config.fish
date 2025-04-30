# your path gets massive and fish becomes very slow.
set -e fish_user_paths
set -U fish_user_paths $HOME/.bin  $HOME/.local/bin $HOME/.config/emacs/bin $HOME/go/bin $HOME/.sdkman $fish_user_paths

set TERM "xterm-256color"                         # Sets the terminal type


# Generated for envman. Do not edit.
test -s ~/.config/envman/load.fish; and source ~/.config/envman/load.fish
# Set ANDROID_HOME
set -x ANDROID_HOME $HOME/Android/Sdk

# Manually append to PATH
set -x PATH $PATH $ANDROID_HOME/emulator
set -x PATH $PATH $ANDROID_HOME/platform-tools

alias xmysql='sudo /opt/lampp/bin/mysql -u root -p'

alias php='sudo /opt/lampp/bin/php-8.2.4'
