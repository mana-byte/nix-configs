#!/usr/bin/env bash

awww-daemon &
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
awww img  ~/.config/me/background/animated/street.gif &
