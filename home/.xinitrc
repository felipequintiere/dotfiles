#!/bin/bash
# note if ~/.xinitrc is not present, startx will use /etc/X11/xinit/xinitrc


xrdb -merge ~/.Xresources # desktop
read -r hostname </etc/hostname
[ "$hostname" = 'note' ] && { # laptop
	xrdb -merge <<EOF
!96, 120, 144 PDI: 1.0x, 1.25x, 1.5x
*dpi: 120
Xft.dpi: 120
EOF
} # "$(cat /etc/hostname)"



setxkbmap \
        -layout us,br \
        -variant altgr-intl, \
        -option ctrl:nocaps,grp:win_space_toggle

xset r rate 200 60
xset -b # bell
xset -c # keyclick

xset s 300 # screen saver
# NOTE: if either dash(-) or 'off' are given,
# the option is to be removed

xset mouse 0 0
xsetroot -cursor_name cross
# 	/usr/include/X11/cursorfont.h



#xsetroot -solid '#f08080'
#xsetroot -solid pink
xsetroot -fg gray20 -bg black -mod 16 16
#xsetroot -gray
# NOTE: foreground  and  background colors are meaningful
# only in combination with -cursor, -bitmap, or -mod
# NOTE: xsetroot [-fg -bg] -bitmap /usr/include/X11/*bitmap_name*



#xconsole &
xterm -geometry 80x24+0+0 &
# NOTE: the -geometry option is interpreted as
# 	WIDTHxHEIGHT+X+Y
# 		80 columns and 24 rows



#exec twm 
exec i3
#exec i3 -c /etc/i3/config # default i3 config
