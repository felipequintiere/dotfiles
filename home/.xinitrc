#!/bin/bash

# XSET(1)
# If the DASH or 'off' are given, the bell will be turned off.
xset -b


# desktop
xrdb -merge ~/.Xresources

# laptop
if grep -q "note" /etc/hostname; then
	xrdb -merge ~/.dpi.Xresources
fi


exec i3
# default i3wm config file
#exec i3 -c /etc/i3/config

