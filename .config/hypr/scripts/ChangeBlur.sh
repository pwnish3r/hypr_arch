#!/bin/bash
# /* ---- 💫 https://github.com/JaKooLit 💫 ---- */  ##
# Script for changing blurs on the fly

notif="$HOME/.config/swaync/images/bell.png"

STATE=$(hyprctl -j getoption decoration:blur:passes | jq ".int")

if [ "${STATE}" == "2" ]; then
	hyprctl keyword decoration:blur:enabled false
	hyprctl keyword decoration:blur:passes 1
 	notify-send -e -u low -i "$notif" "No blur"
else
	hyprctl keyword decoration:blur:enabled true
	hyprctl keyword decoration:blur:new_optimizations true
	hyprctl keyword decoration:blur:size 6
	hyprctl keyword decoration:blur:passes 2
  	notify-send -e -u low -i "$notif" "Normal blur"
fi
