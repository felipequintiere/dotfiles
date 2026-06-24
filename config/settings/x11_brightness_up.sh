#!/bin/bash
#sudo pacman -S bc xorg-xrandr

monitor=$(xrandr | grep -w 'connected' | awk '{printf $1}')

old_brightness=$(cat $HOME/.config/settings/.x11_brightness_log)
new_brightness=$(echo "$old_brightness + 0.05" | bc)

if [ $(echo "$old_brightness == 1.0" | bc) -eq 1 ]; then
	exit
fi

xrandr --output $monitor --brightness $new_brightness
echo "$new_brightness" > $HOME/.config/settings/.x11_brightness_log
echo "#!/bin/bash
xrandr --output $monitor --brightness $new_brightness" > $HOME/.config/settings/.x11_brightness.sh
