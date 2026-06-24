#!/bin/bash

cd $HOME || exit

dwm="$HOME/git/dotfiles/config/dwm/dwm/dwm"
resolution="1920x1080"
display_number=2

Xephyr -br -ac -noreset -screen $resolution :$display_number &

sleep 1
# dwm tries to connect to display :NUMBER, but Xephyr may not be
# ready yet!

DISPLAY=:$display_number $dwm
