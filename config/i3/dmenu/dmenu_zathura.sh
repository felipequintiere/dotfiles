#!/bin/bash

# dmenu color settings
source "$HOME/.config/i3/dmenu/dmenu_vars.sh"

selector=(dmenu -b -i -l 20 -p 'zathura >'
  -fn "$font_family:size=$font_size"
  -nb "$normbgcolor"
  -nf "$normfgcolor"
  -sb "$selbgcolor"
  -sf "$selfgcolor"
)

dir="$HOME/a"
cd "$dir" || exit

selected=$(find ./cs ./ita ./ln ./unix -type f -name '*.pdf' | sed 's|^\./||' | "${selector[@]}")
[ -n "$selected" ] && zathura "$dir/$selected"
