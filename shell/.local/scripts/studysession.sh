#!/bin/bash

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

# Function to prompt user for video quality option
select_video_quality() {
  local option
  read -p "Select an Option (1)720p (2)1080 (3)no-video : " option

  case $option in
    1)
      echo "bestvideo[height<=?720][fps<=?30][vcodec^=avc1]+bestaudio/best"
      ;;
    2)
      echo "bestvideo[height<=?1080][fps<=?30][vcodec^=avc1]+bestaudio/best"
      ;;
    3)
      echo "null"
      ;;
    *)
      echo "Invalid option. Please select a valid option."
      select_video_quality
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

# Prompt user for YouTube link
read -p "Enter the YouTube link: " youtube_link

# Prompt user for video quality option
video_quality=$(select_video_quality)

# Play the YouTube video using mpv with the selected video quality option in the background
mpv --no-resume-playback --ytdl-format="$video_quality" "$youtube_link" &

# Get the process ID of the mpv command
mpv_pid=$!

# Sleep for the specified duration
sleep "$duration_seconds"

# Kill the mpv process
kill "$mpv_pid"

# Power off the laptop
# sudo poweroff
