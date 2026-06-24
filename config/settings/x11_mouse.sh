#!/bin/bash
#sudo pacman -S xorg-xinput
#sudo apt install xinput

id=$(xinput | grep "USB Optical Mouse" | grep -E -o 'id=[[:digit:]]+' | cut -d= -f2)

if [ -n "$id" ]; then
    xinput set-prop "$id" "libinput Accel Profile Enabled" 0 1
fi
