#!/bin/bash

# Path to the AWS credentials file
credentials_file="$HOME/.aws/credentials"

# Check if the credentials file exists
if [ ! -f "$credentials_file" ]; then
    echo "AWS credentials file not found: $credentials_file"
    exit 1
fi

# Extract profile names from the credentials file
profiles=$(awk -F'[][]' '/^\[/{print $2}' "$credentials_file")

# Loop through each profile and print its name
for profile in $profiles; do
    echo "Profile: $profile"
done
