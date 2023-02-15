#!/bin/bash
# export DISPLAY=$(w $(id -un) | awk 'NF > 7 && $2 ~ /tty[0-9]+/ {print $3; exit}')
# echo $DISPLAY
export DISPLAY=:0
xrandr --output $1 --brightness $2
