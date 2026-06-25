#!/bin/sh

id=$(xinput | grep "USB Optical Mouse" | grep -E -o 'id=[[:digit:]]+' | cut -d= -f2)

[ -n "$id" ] && {
    xinput set-prop "$id" "libinput Accel Profile Enabled" 0 1
}
