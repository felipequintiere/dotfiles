#!/bin/bash

current=$(i3-msg -t get_workspaces | jq -r '.[] | select(.focused).name')
next=$(($current+1))

if [ $next -gt 10 ]; then
	next=1
fi

i3-msg "move container to workspace number $next"


