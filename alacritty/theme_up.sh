#!/bin/bash

theme=$(wc -l < $HOME/.config/alacritty/selected_themes)
font_size=$(cat $HOME/.config/alacritty/font_size.log)
opacity=$(cat $HOME/.config/alacritty/opacity.log)

if [ $(cat $HOME/.config/alacritty/current_theme.log) == 1 ];then
	xx=$theme
	echo "$theme" > $HOME/.config/alacritty/current_theme.log
else
	x=$(cat $HOME/.config/alacritty/current_theme.log)
	xx=$(($x-1))
	echo "$(($x - 1))" > $HOME/.config/alacritty/current_theme.log
fi

y=$(sed -n "${xx}p" $HOME/.config/alacritty/selected_themes)

echo "[general]
import = [$y]

[font]
size = $font_size

[window]
opacity = $opacity
padding = {x=10, y=10}" > $HOME/.config/alacritty/alacritty.toml
