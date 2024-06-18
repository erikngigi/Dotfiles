#!/bin/bash

# Define the file extensions to check
extensions=("tf" "tfvars" "tfstate" "tfstate.backup")

# Create an array to store non-empty files
non_empty_files=()

# Loop through files with the specified extensions
for ext in "${extensions[@]}"; do
  for file in *."$ext"; do
    # Check if the file exists and is not empty
    if [ -e "$file" ] && [ -s "$file" ]; then
      non_empty_files+=("$file")
    fi
  done
done

# Check if non-empty files are found
if [ ${#non_empty_files[@]} -eq 0 ]; then
  echo "No non-empty files found."
else
  # Print non-empty files
  echo "Non-empty files found:"
  for file in "${non_empty_files[@]}"; do
    echo "$file"
  done

  # Use tree command to the 4th level and save the output in a markdown file
  tree_output=$(tree -L 4)

  # Save the output in a Markdown file
  output_file="tree_output.md"
  echo "### Directory Tree (up to 4 levels)" > "$output_file"
  echo '```' >> "$output_file"
  echo "$tree_output" >> "$output_file"
  echo '```' >> "$output_file"

  echo "Tree output saved in $output_file"
fi
