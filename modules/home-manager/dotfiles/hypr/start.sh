#!/usr/bin/env bash

swww-daemon &
nm-applet --indicator &
waybar &
dunst &
hypridle &
systemctl --user start hyprpolkitagent &
udiskie --tray &
hyprsunset &
kdeconnectd &
kdeconnect-indicator &
blueman-applet &
wal -i ~/.config/me/background/animated/street.jpg &
swww clear-cache &
swww img  ~/.config/me/background/animated/street.gif &
