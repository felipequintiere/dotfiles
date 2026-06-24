#!/bin/bash

normbgcolor=$(grep -E '^set \$normbgcolor' ~/.config/i3/config | awk '{printf $3}')
normfgcolor=$(grep -E '^set \$normfgcolor' ~/.config/i3/config | awk '{printf $3}')
selbgcolor=$(grep -E '^set \$selbgcolor' ~/.config/i3/config | awk '{printf $3}')
selfgcolor=$(grep -E '^set \$selfgcolor' ~/.config/i3/config | awk '{printf $3}')

font_family=$(grep -E '^set \$font_family' ~/.config/i3/config | awk '{printf $3}')
font_size=$(grep -E '^set \$font_size' ~/.config/i3/config | awk '{printf $3}')


dmenu_colors_file="$HOME/.config/i3/dmenu/dmenu_vars.sh"
echo '#!/bin/bash' > $dmenu_colors_file
echo "normbgcolor=\"$normbgcolor\"" >> $dmenu_colors_file
echo "normfgcolor=\"$normfgcolor\"" >> $dmenu_colors_file
echo "selbgcolor=\"$selbgcolor\"" >> $dmenu_colors_file
echo "selfgcolor=\"$selfgcolor\"" >> $dmenu_colors_file

echo "font_family=$font_family" >> $dmenu_colors_file
echo "font_size=$font_size" >> $dmenu_colors_file
