if status is-interactive
    # Commands to run in interactive sessions can go here
end

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
function y
	set tmp (mktemp -t "yazi-cwd.XXXXXX")
	yazi $argv --cwd-file="$tmp"
	if set cwd (command cat -- "$tmp"); and [ -n "$cwd" ]; and [ "$cwd" != "$PWD" ]
		builtin cd -- "$cwd"
	end
	rm -f -- "$tmp"
end
