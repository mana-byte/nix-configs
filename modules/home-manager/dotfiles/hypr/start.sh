#!/usr/bin/env bash

swww-daemon &
wal -i ~/.config/me/background/animated/street.jpg &
swww img  ~/.config/me/background/animated/street.gif &
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
