#!/usr/bin/env bash

# Terminate already running bar instances
killall -q polybar
# If all your bars have ipc enabled, you can also use
# polybar-msg cmd quit
while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

# Launch bar1 and bar2
polybar eric-1 &

if [[ $(xrandr -q | grep 'DP-2 connected') ]]; then
  polybar eric-2 &
fi
