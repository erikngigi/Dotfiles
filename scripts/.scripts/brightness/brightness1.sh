#!/bin/bash

H=$(date +%k)

if   (( $H >  0 && $H <=  7 )); then
    /usr/bin/xrandr --output HDMI-1 --brightness .3 && /usr/bin/xrandr --output HDMI-2 --brightness .3 && /usr/bin/xrandr --output HDMI-3 --brightness .3
elif (( $H >  7 && $H <= 10 )); then
    /usr/bin/xrandr --output HDMI-1 --brightness .5 && /usr/bin/xrandr --output HDMI-2 --brightness .5 && /usr/bin/xrandr --output HDMI-3 --brightness .5
elif (( $H > 10 && $H <= 19 )); then
    /usr/bin/xrandr --output HDMI-1 --brightness .7 && /usr/bin/xrandr --output HDMI-2 --brightness .7 && /usr/bin/xrandr --output HDMI-3 --brightness .7
elif (( $H > 19 && $H <= 22 )); then
    /usr/bin/xrandr --output HDMI-1 --brightness .5 && /usr/bin/xrandr --output HDMI-2 --brightness .5 && /usr/bin/xrandr --output HDMI-3 --brightness .5
elif (( $H > 22 && $H <= 23 )); then
    /usr/bin/xrandr --output HDMI-1 --brightness .3 && /usr/bin/xrandr --output HDMI-2 --brightness .3 && /usr/bin/xrandr --output HDMI-3 --brightness .3
else
    echo "Error"
fi
