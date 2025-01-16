#!/bin/bash
#sudo pacman -S xorg-xinput
#sudo apt install xinput

mouse_id=$(xinput | grep "Logitech USB Optical Mouse" | grep -o "id=[0-9]*" | cut -d'=' -f2)

if [ -n "$mouse_id" ]; then
    xinput set-prop "$mouse_id" "libinput Accel Profile Enabled" 0 1 0
fi

