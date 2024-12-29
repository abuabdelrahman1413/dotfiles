if status is-interactive
    # Commands to run in interactive sessions can go here
end

### EXPORT ###
set fish_greeting                                 # Supresses fish's intro message
set TERM "xterm-256color"                         # Sets the terminal type
set EDITOR "emacsclient -t -a ''"                 # $EDITOR use Emacs in terminal
set VISUAL "emacsclient -c -a emacs"              # $VISUAL use Emacs in GUI mode



alias emacs="emacsclient -c -a 'emacs'"
alias em='/usr/bin/emacs -nw'
alias rem="killall emacs || echo 'Emacs server not running'; /usr/bin/emacs --daemon" # Kill Emacs and restart daemon..
alias ls="exa --icons -1 --color=always"
alias ll="exa --icons -l --color=always"
alias la="exa --icons -a --color=always"
alias py="python3"
alias update="sudo apt update"
alias upgrade="sudo apt upgrade"
alias install="sudo apt install"
alias list="apt list --upgradeable"
alias i3="nvim ~/dotfiles/i3/.config/i3/config"
source "$HOME/.cargo/env.fish"
export EDITOR="nvim"

function y
	set tmp (mktemp -t "yazi-cwd.XXXXXX")
	yazi $argv --cwd-file="$tmp"
	if set cwd (command cat -- "$tmp"); and [ -n "$cwd" ]; and [ "$cwd" != "$PWD" ]
		builtin cd -- "$cwd"
	end
	rm -f -- "$tmp"
end

set -Ux fish_user_paths ~/.config/emacs/bin $fish_user_paths
set -Ux fish_user_paths ~/.local/bin $fish_user_paths

set -U fish_user_paths $HOME/.bin  $HOME/.local/bin $HOME/.config/emacs/bin $HOME/Applications /var/lib/flatpak/exports/bin/ $fish_user_paths
