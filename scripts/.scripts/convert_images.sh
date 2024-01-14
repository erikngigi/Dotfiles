#!/bin/bash

# Check if cwebp is installed
if ! command -v cwebp &> /dev/null; then
    echo "Error: cwebp is not installed. Please install it before running this script."
    exit 1
fi

# Get user input for the target image extension
read -p "Enter the target image extension (e.g., webp): " target_extension

# Get user input for the quality (default is 80 if user presses Enter without input)
read -p "Enter the quality (default is 80): " quality
quality=${quality:-80}

# Loop through all image files in the current directory
for file in *.{jpg,jpeg,png,gif,bmp}; do
    if [ -f "$file" ]; then
        # Get the file extension (without the dot)
        extension="${file##*.}"

        # Remove the old extension and append the user-defined one
        new_file="${file%.*}.$target_extension"

        # Convert the image using cwebp with user-defined quality
        cwebp -q "$quality" "$file" -o "$new_file"

        # Check if the conversion was successful
        if [ $? -eq 0 ]; then
            echo "Conversion successful: $file -> $new_file"
        else
            echo "Error converting: $file"
        fi
    fi
done

echo "Conversion complete."

