#!/bin/bash

mode=$(cat ~/.config/settings/.toggle_i3bar_log)

if [ $mode -eq 0 ]; then
	i3-msg bar mode dock
	echo 1 > ~/.config/settings/.toggle_i3bar_log
else
	i3-msg bar mode invisible
	echo 0 > ~/.config/settings/.toggle_i3bar_log
fi

