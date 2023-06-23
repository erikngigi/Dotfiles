#!/bin/bash

VIDEO_DIR="$HOME/Anime/Shows"
last_level_dirs=()

# Function to recursively find directories in the last level
find_last_level_dirs() {
  local dir=$1
  
  # Loop through all files and directories in the current directory
  for entry in "$dir"/*; do
    if [[ -d "$entry" ]]; then
      # If it's a directory, check if it contains subdirectories
      subdirs=$(find "$entry" -mindepth 1 -type d)
      if [[ -z "$subdirs" ]]; then
        # If no subdirectories found, add it to the last_level_dirs array
        last_level_dirs+=("$entry")
      else
        # If subdirectories found, recursively call the function for each subdirectory
        find_last_level_dirs "$entry"
      fi
    fi
  done
}

# Find directories in the last level
find_last_level_dirs "$VIDEO_DIR"

# Check if any directories were found
if [ ${#last_level_dirs[@]} -eq 0 ]; then
  echo "No directories found in the last level of $VIDEO_DIR"
  exit 1
fi

# Prompt the user to select a directory from the list
PS3="Select a directory: "
select directory in "${last_level_dirs[@]}"; do
  if [[ -n $directory ]]; then
    break
  else
    echo "Invalid selection. Please choose a valid directory."
  fi
done

# Function to highlight filenames based on FPS
highlight_filename() {
  local filename=$1
  local fps=$2

  if (( $(echo "$fps > 30" | bc -l) )); then
    echo "$(tput setaf 1)$filename$(tput sgr0)"
  else
    echo "$filename" # Highlight filename in red
  fi
}

# Loop through all video files in the selected directory
find "$directory" -type f \( -name "*.mp4" -o -name "*.mkv" -o -name "*.avi" -o -name "*.flv" -o -name "*.wmv" \) -print0 | while IFS= read -r -d '' video_file; do
  # Get the filename without the path
  filename=$(basename "$video_file")
  
  # Use ffprobe to get the FPS
  fps=$(ffprobe -v error -select_streams v:0 -show_entries stream=r_frame_rate -of default=noprint_wrappers=1:nokey=1 "$video_file")

  # Format the FPS to display as xx.xxfps
  formatted_fps=$(bc <<< "scale=2; $fps" | awk '{printf "%.2f", $0}')

  # Print the filename and formatted FPS, with highlighting if FPS < 30
  highlighted_filename=$(highlight_filename "$filename" "$formatted_fps")
  echo "File: $highlighted_filename"
  echo "FPS: $formatted_fps""fps"
  echo
done
