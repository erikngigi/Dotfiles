#!/bin/bash

# directory audio is located
audio_directory="$HOME/YouTube/Audio/sleep/sleep-audio.m4a"

# Function to calculate total seconds from user input
calculate_seconds() {
  local input=$1
  local unit=$2

  case $unit in
    s|S|sec|secs|second|seconds)
      echo "$input"
      ;;
    m|M|min|mins|minute|minutes)
      echo "$(($input * 60))"
      ;;
    h|H|hr|hrs|hour|hours)
      echo "$(($input * 3600))"
      ;;
    *)
      echo "Invalid unit. Please specify 's', 'm', or 'h' for seconds, minutes, or hours, respectively."
      exit 1
      ;;
  esac
}

# Prompt user for duration
read -p "Enter the duration (e.g., 10s, 2m, 1h): " duration_input

# Extract the numeric value and unit from user input
duration_value=$(echo "$duration_input" | grep -oE '[0-9]+')
duration_unit=$(echo "$duration_input" | grep -oE '[a-zA-Z]+$')

# Calculate the total seconds from user input
duration_seconds=$(calculate_seconds "$duration_value" "$duration_unit")

# Validate the calculated duration
if [[ -z $duration_seconds || $duration_seconds -eq 0 ]]; then
  echo "Invalid duration. Please specify a valid number followed by 's', 'm', or 'h'."
  exit 1
fi

# Play the audio file using mpv
# mpv $MPV_OPTION_1=$AUDIO_DIRECTORY &
mpv "$audio_directory" &

# Get the process ID of the mpv command
mpv_pid=$!

# Sleep for the specified duration
sleep "$duration_seconds" 

# Kill the mpv process
kill "$mpv_pid" &

# Power off the laptop
# sudo poweroff
