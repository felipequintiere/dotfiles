#!/bin/bash

bash ~/.config/settings/monitor
bash ~/.config/settings/screensaver
bash ~/.config/settings/brightness
bash ~/.config/settings/keyboard
bash ~/.config/settings/mouse
bash ~/.config/settings/tablet_13_16

picom -f &
bash ~/.fehbg &
