#!/bin/bash

focused_name=$(i3-msg -t get_tree | jq -r '.. | select(.focused? == true) | .name')

cat > ~/.config/picom/invert.conf <<EOF
backend = "glx";
experimental-backends = true;
rules: ({
  match = "name = '$focused_name'";
  invert-color = true;
})
EOF

picom --config ~/.config/picom/invert.conf &

