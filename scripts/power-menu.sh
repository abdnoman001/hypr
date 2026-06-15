#!/bin/bash

# Terminate existing walker dmenu process if running
if pgrep -f "walker.*--dmenu" >/dev/null; then
    walker --close >/dev/null 2>&1
    exit 0
fi

# Ensure walker background service is active
if ! pgrep -f "walker --gapplication-service" >/dev/null; then
    env GSK_RENDERER=cairo walker --gapplication-service &>/dev/null &
    sleep 0.25
fi

# Define options with Nerd Font icons matching Omarchy
options="  Lock\n  Suspend\n󰑓  Relaunch\n󰜉  Restart\n󰐥  Shutdown"

# Launch walker in dmenu mode
chosen=$(echo -e "$options" | walker --dmenu --width 295 --minheight 1 --maxheight 630 -p "System" 2>/dev/null)

# Perform action based on user choice
case "$chosen" in
    *Lock*)
        hyprlock
        ;;
    *Suspend*)
        systemctl suspend
        ;;
    *Relaunch*)
        loginctl terminate-user "$USER" || hyprctl dispatch exit
        ;;
    *Restart*)
        systemctl reboot
        ;;
    *Shutdown*)
        systemctl poweroff
        ;;
    *)
        exit 0
        ;;
esac
