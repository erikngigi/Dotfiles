#!/bin/bash

# check if brave browser is running
is_brave_browser_running() {
  pgrep -x 'brave'
}

# check if mpv is running
is_mpv_running() {
  pgrep -x 'mpv'
}

if is_mpv_running && is_brave_browser_running; then
  # close brave browser
  pkill -SIGTERM 'brave'
fi
