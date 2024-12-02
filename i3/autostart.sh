#!/bin/bash
setxkbmap -layout us,ara
setxkbmap -option grp:alt_shift_toggle
blueman-applet &
picom &
feh --bg-fill ~/Pictures/wallpapers/catppuccin-rainbow-arch.png &
