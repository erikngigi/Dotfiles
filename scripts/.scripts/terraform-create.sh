#!/bin/bash

read -p "Enter project name: " project_name

# Create project directory
mkdir "$project_name"
cd "$project_name" || exit

# Create main Terraform files
touch provider.tf version.tf backend.tf main.tf variables.tf terraform.tfvars outputs.tf

# Append content to provider.tf
cat <<EOF >> provider.tf
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
  region  = "var.region"
  profile = "var.profile"
}
EOF

cat <<EOF >> terraform.tfvars
# terraform variables

region = "us-east-1"
profile = "ericngigi"
EOF

# Create directories
mkdir -p modules/{network,resources} scripts files

echo "Project structure created successfully for $project_name."
