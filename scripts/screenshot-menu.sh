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

# Define options with Nerd Font icons matching Omarchy screenshot layout
options="  Region\n  Window\n  Display"

if [ -n "$1" ]; then
    chosen="$1"
else
    # Launch walker in dmenu mode
    chosen=$(echo -e "$options" | walker --dmenu --width 295 --minheight 1 --maxheight 630 -p "Screenshot" 2>/dev/null)
fi

[[ -z "$chosen" ]] && exit 0

# Set output folder path
OUTPUT_DIR="$HOME/Pictures/Screenshots"
mkdir -p "$OUTPUT_DIR"

FILENAME="screenshot-$(date +'%Y-%m-%d_%H-%M-%S').png"
FILEPATH="$OUTPUT_DIR/$FILENAME"

# Capture using grimblast to file
case "$chosen" in
    *Region*)
        grimblast save area "$FILEPATH"
        ;;
    *Window*)
        grimblast save active "$FILEPATH"
        ;;
    *Display*)
        grimblast save output "$FILEPATH"
        ;;
    *)
        exit 0
        ;;
esac

# Perform post-screenshot operations (wl-copy + satty editor + notification)
if [ -f "$FILEPATH" ]; then
    # Copy to clipboard
    wl-copy < "$FILEPATH"
    
    # Open in satty editor
    satty --filename "$FILEPATH" --output-filename "$FILEPATH" --save-after-copy &
    
    # Send desktop notification
    notify-send -u normal "Screenshot Captured" "Saved to $FILEPATH and copied to clipboard." -i "$FILEPATH"
fi
