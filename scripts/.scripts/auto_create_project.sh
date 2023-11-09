#!/bin/bash

# Define the base directory
base_dir="$HOME/Projects"

# Create the parent directory if it doesnt exist
mkdir -p "$base_dir"

#Find the next available project folder alphabetically
next_project=""
i=65
while true; do
  project_name="Project_$(printf "\\$(printf '%03o' $i)")"
  project_dir="$base_dir/$project_name"

  if [ ! -d "$project_dir" ]; then
    next_project=$project_name
    break
  fi

  i=$((i + 1))
  if [ $i -gt 90 ]; then
    break
  fi
done

if [ -n "$next_project" ]; then
  # Create next project in directory
  mkdir -p "$project_dir"

  # Create the subdirectories withing the project directory
  # mkdir -p "$project_dir/Docs"
  # mkdir -p "$project_dir/Source/Code"
  # mkdir -p "$project_dir/Source/Config"
  # mkdir -p "$project_dir/Tests"

  echo "Created project: $next_project"
else
  echo "No available project slots were found in $base_dir"
fi
