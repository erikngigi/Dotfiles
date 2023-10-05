#!/bin/bash

# Font repository URL
FONT_REPO="https://github.com/ErikNgigi/arch-linux-fonts.git"

# Destination directory for fonts
FONT_DIR="/usr/local/share/fonts"

# Clone the font repository
git clone "$FONT_REPO" /tmp/fonts

# Check if the clone was successful
if [ $? -ne 0 ]; then
	echo "Failed to clone the font repository"
else
	echo "Fonts were successfully downloaded"
fi

# Create the destination directory if it doesn't exist
doas mkdir -p $FONT_DIR

# Move fonts to the destination directory
doas cp -r /tmp/fonts/* "$FONT_DIR/"
echo "Fonts Moved to $FONT_DIR"

# Reload the font cache
fc-cache -f -v

# Clean up the temporary files
rm -rf /tmp/fonts
echo "Temporary Fonts Folder Deleted"
