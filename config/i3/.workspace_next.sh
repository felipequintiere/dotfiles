#!/bin/bash
# sudo pacman -S jq

current=$(i3-msg -t get_workspaces | jq '.[] | select(.focused==true) | .num')
next=$((current + 1))

if [ $next -gt 10 ]; then
  next=1
fi

i3-msg workspace number $next

