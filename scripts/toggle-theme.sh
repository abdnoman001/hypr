#!/bin/bash
# ═══════════════════════════════════════════════════════════
# CachyOS / Hyprland Multi-Theme Chooser Script
# Launches a Rofi menu to select from 4 premium themes:
#   1. Catppuccin Mocha (Pastel Purple/Mauve)
#   2. Tokyo Night (Moody Dark Blue/Purple)
#   3. Gruvbox (Retro Warm Gold/Orange)
#   4. Nord (Arctic Cool Teal/Blue)
#
# Configures:
#   - Hyprland Borders (persistent in hyprland-gui.lua)
#   - Waybar Styles (links style.css to custom theme CSS)
#   - VS Code (updates settings.json theme)
#   - Kitty Terminal (updates current-theme.conf & signals reload)
#   - Brave/GTK Apps (gsettings dark preference and Nord GTK theme)
#   - Wallpaper (sets corresponding theme wallpaper in hyprpaper)
# ═══════════════════════════════════════════════════════════

# Paths
WAYBAR_DIR="$HOME/.config/waybar"
HYPR_DIR="$HOME/.config/hypr"
HYPR_GUI_CONF="$HYPR_DIR/hyprland-gui.lua"
KITTY_DIR="$HOME/.config/kitty"
VSCODE_SETTINGS="$HOME/.config/Code/User/settings.json"
WALLPAPER_DIR="$HOME/.config/waypaper/Wallpaper-Bank/wallpapers"

# Rofi Menu Selection
options="󰄛 Catppuccin\n󰄛 Tokyo Night\n󰄛 Gruvbox\n󰄛 Nord"
chosen=$(echo -e "$options" | rofi -dmenu -i -p "Select Theme" -theme-str 'window {width: 25%;}')

# Exit if no theme selected
[ -z "$chosen" ] && exit 0

# Extract clean name
theme_name=$(echo "$chosen" | awk '{print $2}')
if [ "$chosen" = "󰄛 Tokyo Night" ]; then
    theme_name="Tokyo Night"
fi

# Define Theme Settings
case "$theme_name" in
    "Catppuccin")
        VSCODE_THEME="Catppuccin Mocha"
        KITTY_THEME="catppuccin.conf"
        GTK_THEME="Default"
        COLOR_SCHEME="prefer-dark"
        ICON="preferences-desktop-theme"
        ;;
    "Tokyo Night")
        VSCODE_THEME="Tokyo Night"
        KITTY_THEME="tokyo-night.conf"
        GTK_THEME="Default"
        COLOR_SCHEME="prefer-dark"
        ICON="utilities-terminal"
        ;;
    "Gruvbox")
        VSCODE_THEME="Gruvbox Material Dark"
        KITTY_THEME="gruvbox.conf"
        GTK_THEME="Default"
        COLOR_SCHEME="prefer-dark"
        ICON="preferences-desktop-theme"
        ;;
    "Nord")
        VSCODE_THEME="Nord"
        KITTY_THEME="nord.conf"
        GTK_THEME="cachyos-nord"
        COLOR_SCHEME="prefer-dark"
        ICON="preferences-desktop-theme"
        WALLPAPER="$WALLPAPER_DIR/Fog-Forest-Everforest.png"
        ;;
    *)
        exit 0
        ;;
esac

# 1. Update VS Code Theme
if [ -f "$VSCODE_SETTINGS" ]; then
    jq --arg theme "$VSCODE_THEME" '.["workbench.colorTheme"] = $theme' "$VSCODE_SETTINGS" > /tmp/vscode_settings.json
    mv /tmp/vscode_settings.json "$VSCODE_SETTINGS"
fi

# 2. Update Kitty Terminal Theme
if [ -d "$KITTY_DIR" ]; then
    ln -sf "$KITTY_DIR/themes/$KITTY_THEME" "$KITTY_DIR/current-theme.conf"
    killall -USR1 kitty 2>/dev/null || true
fi


# 4. Update GTK Themes (Brave Browser, etc.)
gsettings set org.gnome.desktop.interface gtk-theme "$GTK_THEME" 2>/dev/null || true
gsettings set org.gnome.desktop.interface color-scheme "$COLOR_SCHEME" 2>/dev/null || true


# Send premium replacement notification
notify-send -h string:x-canonical-private-synchronous:theme-switch \
            -u normal \
            "Theme Applied" \
            "Switched to $theme_name Theme" \
            -i "$ICON"
