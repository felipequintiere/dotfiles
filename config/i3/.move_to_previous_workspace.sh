#!/bin/bash

current=$(i3-msg -t get_workspaces | jq -r '.[] | select(.focused).name')
previous=$(($current-1))

if [ $previous -lt 1 ]; then
	previous=10
fi

i3-msg "move container to workspace number $previous" 
