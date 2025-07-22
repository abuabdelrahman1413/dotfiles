#!/bin/bash

# Simple script for a rofi-based power menu

# Options for the power menu
options="Shutdown
Reboot
Sleep"

# Get the user's choice
chosen=$(echo -e "$options" | rofi -dmenu -i -p "Power" -theme /home/mohammed/dotfiles/rofi/.config/rofi/power.rasi)

# Execute the chosen command
case "$chosen" in
    "Shutdown")
        systemctl poweroff
        ;;
    "Reboot")
        systemctl reboot
        ;;
    "Sleep")
        systemctl suspend
        ;;
    *)
        exit 1
        ;;
esac
