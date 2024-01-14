#!/usr/bin/env bash

# Terminate already running bar instances
killall -q polybar
# If all your bars have ipc enabled, you can also use 
# polybar-msg cmd quit
while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

# Launch bar1 and bar2
polybar eric &

# if [[ $(xrandr -q | grep 'VGA-0 connected') ]]; then
#   polybar eric &
# fi
