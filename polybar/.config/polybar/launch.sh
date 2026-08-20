#!/usr/bin/env bash

# Terminate already running bar instances

polybar-msg cmd quit 2>/dev/null || killall -q polybar

# Wait until processes have been shut down
while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

# Ensure the root wallpaper pixmap is loaded before Polybar draws transparency
if [ -f "$HOME/.fehbg" ]; then
  sh "$HOME/.fehbg"
fi

# Launch bar1 and bar2
polybar eric-1 &

if [[ $(xrandr -q | grep 'DP-2 connected') ]]; then
  polybar eric-2 &
fi
