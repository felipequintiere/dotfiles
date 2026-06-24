#!/bin/bash

#$ xsetwacom --list devices
#HID 256c:006d Pen stylus        	id: 6	type: STYLUS
#HID 256c:006d Pad pad           	id: 7	type: PAD
#HID 256c:006d Touch Strip pad   	id: 8	type: PAD
#HID 256c:006d Dial pad          	id: 9	type: PAD

main="HID 256c:006d Pen stylus"
buttons="HID 256c:006d Pad pad"

xsetwacom set "$main" Rotate half
xsetwacom set "$main" Area 0 0 32000 18000

xsetwacom set "$main" Button 2 "key +ctrl +Shift p -Shift -ctrl"
xsetwacom set "$main" Button 3 "key +ctrl +Shift e -Shift -ctrl"

xsetwacom set "$buttons" Button 10 "key +ctrl +Shift + -Shift -ctrl"
xsetwacom set "$buttons" Button 9 "key +ctrl - -ctrl"
xsetwacom set "$buttons" Button 8 "key +ctrl +Shift a -Shift -ctrl"
xsetwacom set "$buttons" Button 3 "key +ctrl +Shift g -Shift -ctrl"
xsetwacom set "$buttons" Button 2 "key +ctrl +Shift z -Shift -ctrl"
xsetwacom set "$buttons" Button 1 "key +ctrl z -ctrl"
