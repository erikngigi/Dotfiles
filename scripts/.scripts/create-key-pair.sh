#!/usr/bin/env bash

# prompt the user for the key name
read -p "Enter the key name: " KEY_NAME

# prompt the user for the key type (default: rsa)
read -p "Enter the key type (default: rsa): " KEY_TYPE
KEY_TYPE=${KEY_TYPE:-rsa}

# prompt the user for the key format (default: pem)
read -p "Enter the key format (default: pem): " KEY_FORMAT
KEY_FORMAT=${KEY_FORMAT:-pem}

# directory where key will be saved
OUTPUT_DIR="$HOME/.ssh"

# define full path of the pem file
OUTPUT_FILE="$OUTPUT_DIR/$KEY_NAME.pem"

# define region
PROFILE="tf-ericngigi"

# Execute the AWS CLI command to create the key pair and save the .pem file
aws ec2 create-key-pair --key-name "$KEY_NAME" --key-type "$KEY_TYPE" --key-format "$KEY_FORMAT" --query "KeyMaterial" --profile "$PROFILE" --output text > "$OUTPUT_FILE"

# Check if the command was successful
if [ $? -eq 0 ]; then
    echo "Key pair created and saved to $OUTPUT_FILE"
else
    echo "Failed to create key pair."
fi
