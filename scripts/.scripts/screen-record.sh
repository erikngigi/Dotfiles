#!/bin/bash

# screen recording variables
screen_ratio="1366x768"
framerate="30"
video_input_device="x11grab"
screen_capture_dimensions=":0.0+0,0"
probesize="42M"
# audio_input_device="alsa -ac 2 -i hw:0"

# directory output
output_directory="$HOME/Desktop/"

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
ffmpeg -video_size "$screen_ratio" -framerate "$framerate" -f "$video_input_device" -i "$screen_capture_dimensions" -f alsa -ac 2 -i hw:0 -probesize "$probesize" "$output_path"

echo "Screen recording saved as: $output_path"
