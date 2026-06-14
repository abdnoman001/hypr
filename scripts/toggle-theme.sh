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
ANTIGRAVITY_SETTINGS="$HOME/.config/Antigravity IDE/User/settings.json"
WALLPAPER_DIR="$HOME/.config/waypaper/Wallpaper-Bank/wallpapers"

# Determine Theme Name (via Argument or Rofi Menu)
if [ -n "$1" ]; then
    theme_name="$1"
else
    # Rofi Menu Selection
    options="󰄛 Catppuccin\n󰄛 Tokyo Night\n󰄛 Gruvbox\n󰄛 Nord\n󰄛 Lumon\n󰄛 Osaka Jade\n󰄛 Matte Black\n󰄛 Ristretto\n󰄛 Flexoki Light"
    chosen=$(echo -e "$options" | rofi -dmenu -i -p "Select Theme" -theme-str 'window {width: 25%;}')

    # Exit if no theme selected
    [ -z "$chosen" ] && exit 0

    # Extract clean name (supporting names with spaces)
    theme_name=$(echo "$chosen" | cut -d' ' -f2-)
fi

# Define Theme Settings
case "$theme_name" in
    "Catppuccin")
        VSCODE_THEME="Catppuccin Mocha"
        ANTIGRAVITY_THEME="Catppuccin Mocha"
        KITTY_THEME="catppuccin.conf"
        GTK_THEME="Catppuccin-Mocha"
        COLOR_SCHEME="prefer-dark"
        ICON="preferences-desktop-theme"
        WALLPAPER="$WALLPAPER_DIR/Lofi - Chill Room.png"
        BACKGROUND="#1e1e2e"
        FOREGROUND="#cdd6f4"
        ACCENT="#cba6f7"
        COLOR1="#f38ba8"
        COLOR2="#a6e3a1"
        ACTIVE_BORDER="0xffcba6f7"
        INACTIVE_BORDER="0xff313244"
        ;;
    "Tokyo Night")
        VSCODE_THEME="Tokyo Night"
        ANTIGRAVITY_THEME="Tokyo Night"
        KITTY_THEME="tokyo-night.conf"
        GTK_THEME="Tokyonight-Dark"
        COLOR_SCHEME="prefer-dark"
        ICON="utilities-terminal"
        WALLPAPER="$WALLPAPER_DIR/tokyo-night-1-sunset-lake.png"
        BACKGROUND="#1a1b26"
        FOREGROUND="#a9b1d6"
        ACCENT="#7aa2f7"
        COLOR1="#f7768e"
        COLOR2="#9ece6a"
        ACTIVE_BORDER="0xff7aa2f7"
        INACTIVE_BORDER="0xff1f2335"
        ;;
    "Gruvbox")
        VSCODE_THEME="Gruvbox Dark Medium"
        ANTIGRAVITY_THEME="Gruvbox Dark Medium"
        KITTY_THEME="gruvbox.conf"
        GTK_THEME="gruvbox-dark-gtk"
        COLOR_SCHEME="prefer-dark"
        ICON="preferences-desktop-theme"
        WALLPAPER="$WALLPAPER_DIR/gruvbox-1-the-backwater.jpg"
        BACKGROUND="#282828"
        FOREGROUND="#d4be98"
        ACCENT="#7daea3"
        COLOR1="#ea6962"
        COLOR2="#a9b665"
        ACTIVE_BORDER="0xff7daea3"
        INACTIVE_BORDER="0xff3c3836"
        ;;
    "Nord")
        VSCODE_THEME="Nord"
        ANTIGRAVITY_THEME="Nord"
        KITTY_THEME="nord.conf"
        GTK_THEME="cachyos-nord"
        COLOR_SCHEME="prefer-dark"
        ICON="preferences-desktop-theme"
        WALLPAPER="$WALLPAPER_DIR/Courtside-Sunset.png"
        BACKGROUND="#2e3440"
        FOREGROUND="#d8dee9"
        ACCENT="#88c0d0"
        COLOR1="#bf616a"
        COLOR2="#a3be8c"
        ACTIVE_BORDER="0xff88c0d0"
        INACTIVE_BORDER="0xff3b4252"
        ;;
    "Lumon")
        VSCODE_THEME="Lumon"
        ANTIGRAVITY_THEME="Lumon"
        KITTY_THEME="lumon.conf"
        GTK_THEME="Lumon-Dark"
        COLOR_SCHEME="prefer-dark"
        ICON="preferences-desktop-theme"
        WALLPAPER="$WALLPAPER_DIR/lumon-01-united-in-severance.jpg"
        BACKGROUND="#16242d"
        FOREGROUND="#d6e2ee"
        ACCENT="#8bc9eb"
        COLOR1="#4d86b0"
        COLOR2="#5e95bc"
        ACTIVE_BORDER="0xff8bc9eb"
        INACTIVE_BORDER="0xff1b2d40"
        ;;
    "Osaka Jade")
        VSCODE_THEME="Ocean Green: Dark"
        ANTIGRAVITY_THEME="Ocean Green: Dark"
        KITTY_THEME="osaka-jade.conf"
        GTK_THEME="Osaka-Jade-Dark"
        COLOR_SCHEME="prefer-dark"
        ICON="preferences-desktop-theme"
        WALLPAPER="$WALLPAPER_DIR/osaka-jade-1-glowing-city.jpg"
        BACKGROUND="#111c18"
        FOREGROUND="#c1c497"
        ACCENT="#509475"
        COLOR1="#ff5345"
        COLOR2="#549e6a"
        ACTIVE_BORDER="0xff509475"
        INACTIVE_BORDER="0xff23372b"
        ;;
    "Matte Black")
        VSCODE_THEME="Matte Black"
        ANTIGRAVITY_THEME="Matte Black"
        KITTY_THEME="matte-black.conf"
        GTK_THEME="Matte-Black-Dark"
        COLOR_SCHEME="prefer-dark"
        ICON="preferences-desktop-theme"
        WALLPAPER="$WALLPAPER_DIR/matte-black-0-ship-at-sea.jpg"
        BACKGROUND="#121212"
        FOREGROUND="#bebebe"
        ACCENT="#e68e0d"
        COLOR1="#d35f5f"
        COLOR2="#ffc107"
        ACTIVE_BORDER="0xffe68e0d"
        INACTIVE_BORDER="0xff333333"
        ;;
    "Ristretto")
        VSCODE_THEME="Monokai Pro (Filter Ristretto)"
        ANTIGRAVITY_THEME="Monokai Pro (Filter Ristretto)"
        KITTY_THEME="ristretto.conf"
        GTK_THEME="Ristretto-Dark"
        COLOR_SCHEME="prefer-dark"
        ICON="preferences-desktop-theme"
        WALLPAPER="$WALLPAPER_DIR/ristretto-2-coffee-beans.jpg"
        BACKGROUND="#2c2525"
        FOREGROUND="#e6d9db"
        ACCENT="#f38d70"
        COLOR1="#fd6883"
        COLOR2="#adda78"
        ACTIVE_BORDER="0xfff38d70"
        INACTIVE_BORDER="0xff403e41"
        ;;
    "Flexoki Light")
        VSCODE_THEME="flexoki-light"
        ANTIGRAVITY_THEME="flexoki-light"
        KITTY_THEME="flexoki-light.conf"
        GTK_THEME="Flexoki-Light"
        COLOR_SCHEME="prefer-light"
        ICON="preferences-desktop-theme"
        WALLPAPER="$WALLPAPER_DIR/flexoki-light-1-orb.png"
        BACKGROUND="#fffcf0"
        FOREGROUND="#100f0f"
        ACCENT="#205ea6"
        COLOR1="#d14d41"
        COLOR2="#879a39"
        ACTIVE_BORDER="0xff205ea6"
        INACTIVE_BORDER="0xffdad8ce"
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

# Update Antigravity IDE Theme
if [ -f "$ANTIGRAVITY_SETTINGS" ]; then
    jq --arg theme "$ANTIGRAVITY_THEME" '.["workbench.colorTheme"] = $theme' "$ANTIGRAVITY_SETTINGS" > /tmp/antigravity_settings.json
    mv /tmp/antigravity_settings.json "$ANTIGRAVITY_SETTINGS"
fi

# 2. Update Kitty Terminal Theme
if [ -d "$KITTY_DIR" ]; then
    ln -sf "$KITTY_DIR/themes/$KITTY_THEME" "$KITTY_DIR/current-theme.conf"
    killall -USR1 kitty 2>/dev/null || true
fi

# 3. Update Wallpaper (hyprpaper and waypaper)
if [ -n "$WALLPAPER" ]; then
    # Write new block-style config to hyprpaper.conf
    cat <<EOF > "$HYPR_DIR/hyprpaper.conf"
wallpaper {
    monitor = 
    path = $WALLPAPER
}
EOF

    # Sync waypaper config.ini to match the new wallpaper
    WAYPAPER_CONFIG="$HOME/.config/waypaper/config.ini"
    if [ -f "$WAYPAPER_CONFIG" ]; then
        sed -i "s|^wallpaper = .*|wallpaper = $WALLPAPER|g" "$WAYPAPER_CONFIG"
    fi

    # Restart hyprpaper daemon to apply the wallpaper instantly
    killall hyprpaper 2>/dev/null || true
    hyprpaper >/dev/null 2>&1 &
fi

# Helper function to convert hex to decimal RGB
hex_to_rgb() {
    local hex=$(echo "$1" | sed 's/#//')
    local r=$(printf "%d" "0x${hex:0:2}")
    local g=$(printf "%d" "0x${hex:2:2}")
    local b=$(printf "%d" "0x${hex:4:2}")
    echo "$r,$g,$b"
}

# 4. Update GTK Themes (Brave Browser, etc.) and stylesheets
# If the selected theme is a custom one (not gruvbox or nord which are pre-installed package directories),
# we dynamically install it locally under ~/.themes by building the directory structure and writing color configs.
if [ "$GTK_THEME" != "gruvbox-dark-gtk" ] && [ "$GTK_THEME" != "cachyos-nord" ] && [ "$GTK_THEME" != "Default" ]; then
    mkdir -p "$HOME/.themes/$GTK_THEME/gtk-3.0" "$HOME/.themes/$GTK_THEME/gtk-4.0"
    
    # Create index.theme file for the local GTK theme
    cat <<EOF > "$HOME/.themes/$GTK_THEME/index.theme"
[Desktop Entry]
Type=X-GNOME-Metatheme
Name=$GTK_THEME
Comment=$theme_name GTK Theme
Encoding=UTF-8
EOF

    # Write stylesheet inside the theme folder
    for gtk_dir in "$HOME/.themes/$GTK_THEME/gtk-3.0" "$HOME/.themes/$GTK_THEME/gtk-4.0"; do
        cat <<EOF > "$gtk_dir/gtk.css"
@define-color theme_bg_color $BACKGROUND;
@define-color theme_fg_color $FOREGROUND;
@define-color theme_base_color $BACKGROUND;
@define-color theme_text_color $FOREGROUND;
@define-color theme_selected_bg_color $ACCENT;
@define-color theme_selected_fg_color $BACKGROUND;
@define-color accent_color $ACCENT;
@define-color accent_bg_color $ACCENT;

@define-color window_bg_color $BACKGROUND;
@define-color window_fg_color $FOREGROUND;
@define-color view_bg_color $BACKGROUND;
@define-color view_fg_color $FOREGROUND;
@define-color headerbar_bg_color $BACKGROUND;
@define-color headerbar_fg_color $FOREGROUND;
@define-color popover_bg_color $BACKGROUND;
@define-color popover_fg_color $FOREGROUND;
@define-color card_bg_color $BACKGROUND;
@define-color card_fg_color $FOREGROUND;
EOF
    done
fi

gsettings set org.gnome.desktop.interface gtk-theme "$GTK_THEME" 2>/dev/null || true
gsettings set org.gnome.desktop.interface color-scheme "$COLOR_SCHEME" 2>/dev/null || true

# Update general user-wide GTK 3 & 4 overrides stylesheets dynamically
mkdir -p "$HOME/.config/gtk-3.0" "$HOME/.config/gtk-4.0"
for gtk_dir in "$HOME/.config/gtk-3.0" "$HOME/.config/gtk-4.0"; do
    cat <<EOF > "$gtk_dir/gtk.css"
@define-color theme_bg_color $BACKGROUND;
@define-color theme_fg_color $FOREGROUND;
@define-color theme_base_color $BACKGROUND;
@define-color theme_text_color $FOREGROUND;
@define-color theme_selected_bg_color $ACCENT;
@define-color theme_selected_fg_color $BACKGROUND;
@define-color accent_color $ACCENT;
@define-color accent_bg_color $ACCENT;

@define-color window_bg_color $BACKGROUND;
@define-color window_fg_color $FOREGROUND;
@define-color view_bg_color $BACKGROUND;
@define-color view_fg_color $FOREGROUND;
@define-color headerbar_bg_color $BACKGROUND;
@define-color headerbar_fg_color $FOREGROUND;
@define-color popover_bg_color $BACKGROUND;
@define-color popover_fg_color $FOREGROUND;
@define-color card_bg_color $BACKGROUND;
@define-color card_fg_color $FOREGROUND;
EOF
done

# 5. Update Hyprland Borders
if [ -f "$HYPR_GUI_CONF" ]; then
    sed -i "s|active_border = .*|active_border = \"$ACTIVE_BORDER\",|g" "$HYPR_GUI_CONF"
    sed -i "s|inactive_border = .*|inactive_border = \"$INACTIVE_BORDER\",|g" "$HYPR_GUI_CONF"
    hyprctl reload 2>/dev/null || true
fi



# 7. Update Swaylock (Unlock Screen) configuration
SWAYLOCK_CONFIG="$HOME/.config/swaylock/config"
mkdir -p "$HOME/.config/swaylock"

# Parse colors (removing # prefix)
bg_raw=$(echo "$BACKGROUND" | sed 's/#//')
fg_raw=$(echo "$FOREGROUND" | sed 's/#//')
accent_raw=$(echo "$ACCENT" | sed 's/#//')
color1_raw=$(echo "$COLOR1" | sed 's/#//')
color2_raw=$(echo "$COLOR2" | sed 's/#//')

cat <<EOF > "$SWAYLOCK_CONFIG"
clock
indicator
font="JetBrainsMono Nerd Font"
font-size=16

image=$WALLPAPER
scaling=fill
effect-blur=7x5

text-color=${fg_raw}FF
text-clear-color=${accent_raw}FF
text-ver-color=${accent_raw}FF
text-wrong-color=${color1_raw}FF

inside-color=${bg_raw}CC
inside-clear-color=${bg_raw}CC
inside-ver-color=${bg_raw}CC
inside-wrong-color=${bg_raw}CC

ring-color=${accent_raw}FF
ring-clear-color=${color2_raw}FF
ring-ver-color=${color2_raw}FF
ring-wrong-color=${color1_raw}FF

key-hl-color=${accent_raw}FF
bs-hl-color=${color1_raw}FF
separator-color=00000000
line-uses-ring=true
EOF


# Send premium replacement notification
notify-send -h string:x-canonical-private-synchronous:theme-switch \
            -u normal \
            "Theme Applied" \
            "Switched to $theme_name Theme" \
            -i "$ICON"
