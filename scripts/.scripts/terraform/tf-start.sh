#!/bin/bash

# Function to create directory structure
create_directory_structure() {
    # Create Documentation directory
    mkdir -p "$1/documentation"
    
    # Create Environment directory
    # mkdir -p "$1/environment/development"
    # mkdir -p "$1/environment/staging"
    # mkdir -p "$1/environment/production"

    # Create infrastructure directory
    mkdir -p "$1/infrastructure/modules"
    
    # Create Media directory 
    mkdir -p "$1/files"

    # Create modules subdirectories
    mkdir -p "$1/infrastructure/modules/containers"
    mkdir -p "$1/infrastructure/modules/instances"
    mkdir -p "$1/infrastructure/modules/database"
    mkdir -p "$1/infrastructure/modules/management"
    mkdir -p "$1/infrastructure/modules/network"
    mkdir -p "$1/infrastructure/modules/notifications"
    mkdir -p "$1/infrastructure/modules/scaling"
    mkdir -p "$1/infrastructure/modules/security"
    mkdir -p "$1/infrastructure/modules/storage"

    # Create templates subdirectories
    mkdir -p "$1/infrastructure/modules/containers/templates"
    mkdir -p "$1/infrastructure/modules/notifications/templates"
    mkdir -p "$1/infrastructure/modules/security/templates"

    # Create main.tf, outputs.tf, variables.tf, and versions.tf files
    touch "$1/infrastructure/main.tf"
    touch "$1/infrastructure/outputs.tf"
    touch "$1/infrastructure/variables.tf"
    touch "$1/infrastructure/provider.tf"
    touch "$1/infrastructure/terraform.tfvars"

    touch "$1/infrastructure/modules/containers/main.tf"
    touch "$1/infrastructure/modules/containers/outputs.tf"
    touch "$1/infrastructure/modules/containers/variables.tf"
    touch "$1/infrastructure/modules/containers/versions.tf"
    touch "$1/infrastructure/modules/containers/templates/app.json.tpl"

    touch "$1/infrastructure/modules/instances/main.tf"
    touch "$1/infrastructure/modules/instances/outputs.tf"
    touch "$1/infrastructure/modules/instances/variables.tf"
    touch "$1/infrastructure/modules/instances/versions.tf"

    touch "$1/infrastructure/modules/management/main.tf"
    touch "$1/infrastructure/modules/management/outputs.tf"
    touch "$1/infrastructure/modules/management/variables.tf"
    touch "$1/infrastructure/modules/management/versions.tf"

    touch "$1/infrastructure/modules/network/main.tf"
    touch "$1/infrastructure/modules/network/outputs.tf"
    touch "$1/infrastructure/modules/network/variables.tf"
    touch "$1/infrastructure/modules/network/versions.tf"

    touch "$1/infrastructure/modules/notifications/main.tf"
    touch "$1/infrastructure/modules/notifications/outputs.tf"
    touch "$1/infrastructure/modules/notifications/variables.tf"
    touch "$1/infrastructure/modules/notifications/versions.tf"
    touch "$1/infrastructure/modules/notifications/templates/email-sns-stack.json.tpl"

    touch "$1/infrastructure/modules/scaling/main.tf"
    touch "$1/infrastructure/modules/scaling/outputs.tf"
    touch "$1/infrastructure/modules/scaling/variables.tf"

    touch "$1/infrastructure/modules/security/main.tf"
    touch "$1/infrastructure/modules/security/outputs.tf"
    touch "$1/infrastructure/modules/security/variables.tf"
    touch "$1/infrastructure/modules/security/versions.tf"
    touch "$1/infrastructure/modules/security/templates/ecs-ec2-role-policy.json.tpl"
    touch "$1/infrastructure/modules/security/templates/ecs-ec2-role.json.tpl"
    touch "$1/infrastructure/modules/security/templates/ecs-service-role.json.tpl"

    touch "$1/infrastructure/modules/storage/main.tf"
    touch "$1/infrastructure/modules/storage/outputs.tf"
    touch "$1/infrastructure/modules/storage/variables.tf"
    touch "$1/infrastructure/modules/storage/versions.tf"

    # Append provider information to provider.tf
    cat <<EOF >> "$1/infrastructure/provider.tf"
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

# Configure the AWS Provider
provider "aws" {
  region                   = "us-east-1"
  shared_config_files      = ["~/.aws/config"]
  shared_credentials_files = ["~/.aws/credentials"]
  profile                  = "ericngigi"
}
EOF

    echo "Directory structure created successfully."
}

main() {
    echo "Current working directory: $(pwd)"
    read -r -p "Do you want to create a root directory? (yes[y]/no[n]): " answer
    case "$answer" in
        [yY]|[yY][eE][sS])
            # Prompt the user until a valid directory name is provided
            while true; do
                read -r -p "Enter the root directory name (no spaces, only hyphens or underscores allowed): " root_directory_name
                # Check if directory already exists
                if [[ -d "$root_directory_name" ]]; then
                    echo "Directory '$root_directory_name' already exists. Please enter a new directory name."
                # Check if directory name contains only allowed characters
                elif [[ ! "$root_directory_name" =~ ^[a-zA-Z0-9_-]+$ ]]; then
                    echo "Invalid directory name. Only letters, numbers, hyphens (-), and underscores (_) are allowed."
                else
                    create_directory_structure "$root_directory_name"
                    break
                fi
            done
            ;;
        [nN]|[nN][oO])
            echo "Exiting without creating a root directory."
            ;;
        *)
            echo "Invalid input. Exiting without creating a root directory."
            ;;
    esac
}

# Execute main function
main

