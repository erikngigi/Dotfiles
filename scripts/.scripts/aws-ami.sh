#!/bin/bash

# List of Ubuntu versions you want to get AMIs for
ubuntu_versions=("noble" "jammy" "focal")

# AWS region
profile="ericngigi"

# Loop through the Ubuntu versions and get the AMI IDs
for version in "${ubuntu_versions[@]}"; do
  # Use the AWS CLI to describe images and filter by name and owner
  ami_id=$(aws ec2 describe-images --profile "$profile"\
    --filters "Name=name,Values=ubuntu/images/hvm-ssd/ubuntu-$version*" "Name=root-device-type,Values=ebs" "Name=architecture,Values=x86_64" \
    --owners "amazon" \
    --query "sort_by(Images, &CreationDate)[-1].[ImageId]" --output text)
  
  # Check if an AMI ID was found and print it
  if [ "$ami_id" != "None" ]; then
    echo "Ubuntu-$version AMI ID: $ami_id"
  else
    echo "No AMI found for Ubuntu $version"
  fi
done
