#!/bin/bash

# dmenu color settings
source "$HOME/.config/i3/dmenu/dmenu_vars.sh"

selector=(dmenu -b -i -l 20 -p 'xournalpp >'
  -fn "$font_family:size=$font_size"
  -nb "$normbgcolor"
  -nf "$normfgcolor"
  -sb "$selbgcolor"
  -sf "$selfgcolor"
)

dir="$HOME/.config/i3/graphics_tablet"
cd "$dir" || exit

selected=$(ls | "${selector[@]}")
[ -n "$selected" ] && $dir/$selected
