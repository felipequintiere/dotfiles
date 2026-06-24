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

dir="$HOME/a/anotacoes"
cd "$dir" || exit

selected=$(find . -type f -name '*.xopp' | sed 's|^\./||' | "${selector[@]}")
[ -n "$selected" ] && xournalpp "$dir/$selected"
