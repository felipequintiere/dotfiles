#!/bin/sh

monitor=$(xrandr --query | awk '/ connected/{printf $1}')
refresh_rate='74.97'

case "$monitor" in 
	HDMI-A-[0-9])
		xrandr --output "$monitor" \
			--mode 1920x1080 \
			--rate "$refresh_rate"
		;;
	HDMI-[0-9])
		xrandr --output "$monitor" \
			--mode 1920x1080 \
			--rate "$refresh_rate"
		;;
	eDP*)
		xrandr --output "$monitor" --mode 1920x1080
		#xrandr --output "$monitor" --mode 1680x1050
		#xrandr --output "$monitor" --mode 1280x1024
		;;
esac
