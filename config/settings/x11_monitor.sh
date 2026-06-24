#!/bin/sh

MONITOR=$(xrandr --query | awk '/ connected/{printf $1}')

case "$MONITOR" in 
	HDMI-A-[[:digit:]])
		xrandr --output $MONITOR --mode 1920x1080 --rate 74.97
		;;
	HDMI-[[:digit:]])
		xrandr --output $MONITOR --mode 1920x1080 --rate 74.97
		;;
	eDP)
		xrandr --output $MONITOR --mode 1920x1080
		#xrandr --output $MONITOR --mode 1680x1050
		#xrandr --output $MONITOR --mode 1280x1024
		;;
esac
