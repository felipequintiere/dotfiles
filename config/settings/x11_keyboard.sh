#!/bin/sh

readonly USB_DEVICES=$(lsusb)
readonly DESKTOP_KEYBOARD_ID="17ef:6099"

xset r rate 250 55
setxkbmap \
	-layout us,br \
	-variant altgr-intl, \
	-option ctrl:nocaps,grp:win_space_toggle

if echo "$USB_DEVICES" | grep -q "$DESKTOP_KEYBOARD_ID"; then
	xset r rate 200 70
	setxkbmap \
		-layout us,br \
		-variant altgr-intl, \
		-option ctrl:nocaps,grp:win_space_toggle

	# NOTE: use xev to see the keycodes
	xmodmap -e "keycode 94 = dead_tilde dead_circumflex"
	xmodmap -e "keycode 97 = F13 dead_circumflex"

#	xmodmap -e "keycode 134 = ISO_Level3_Shift"
#	xmodmap -e "add Mod5 = ISO_Level3_Shift"
fi

# note: setxkbmap adds options specified in the command line to the options
# that were set before (as saved in root window properties). If you want to
# replace all previously specified options, use the -option flag with an
# empty argument first.
	

