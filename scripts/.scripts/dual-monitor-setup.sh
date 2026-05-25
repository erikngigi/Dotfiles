#!/usr/bin/env bash

set -euo pipefail

# Dual monitor setup
# DP-2: left monitor
# DP-1: right monitor (primary)
xrandr \
  --output DP-1 --primary --mode 1920x1080 --pos 1920x0 --rotate normal \
  --output DP-2 --mode 1920x1080 --pos 0x0 --rotate normal
