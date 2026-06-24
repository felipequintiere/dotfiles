#!/bin/bash

main="HID 256c:006d Pen stylus"
buttons="HID 256c:006d Pad pad"

xsetwacom set "$main" Rotate half
xsetwacom set "$main" Area 0 0 32000 18000

xsetwacom set "$main" Button 2 "button 1"
xsetwacom set "$main" Button 3 "button 3"

xsetwacom set "$buttons" Button 10 "key +ctrl +Shift + -Shift -ctrl"
xsetwacom set "$buttons" Button 9 "key +ctrl - -ctrl"
xsetwacom set "$buttons" Button 8 "key +ctrl +Shift a -Shift -ctrl"
xsetwacom set "$buttons" Button 3 "key +ctrl +Shift g -Shift -ctrl"
xsetwacom set "$buttons" Button 2 "key +ctrl +Shift z -Shift -ctrl"
xsetwacom set "$buttons" Button 1 "key +ctrl z -ctrl"
