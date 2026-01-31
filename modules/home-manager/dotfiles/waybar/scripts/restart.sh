#!/home/mana/.nix-profile/bin/bash
echo "Restarting Waybar..."
pkill waybar 
sleep 2.5 
waybar &

