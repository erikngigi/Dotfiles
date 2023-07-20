#!/bin/bash

# screen recording variables
screen_ratio="1920x1080"
framerate="30"
video_input_device="x11grab"
screen_capture_dimensions=":0.0+0,0"
probesize="42M"

# directory output
output_directory="$HOME/Recordings/Videos"

echo "Press q to stop."
echo "Enter the name of the screen recording (without extension):"
read -r output_name

if [ -z "$output_name" ]; then
  echo "Error: You must enter a valid name for the screen recording."
  exit 1
fi

output_file="${output_name}.mkv"
output_path="${output_directory}/${output_file}"

# ffmpeg command
ffmpeg -video_size "$screen_ratio" -framerate "$framerate" -f "$video_input_device" -i "$screen_capture_dimensions" -probesize "$probesize" "$output_path"

echo "Screen recording saved as: $output_path"
