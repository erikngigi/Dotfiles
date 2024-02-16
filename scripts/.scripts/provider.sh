#!/bin/bash

# Define the Terraform configuration to append
TERRAFORM_CONFIG=$(cat <<EOL
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
  region  = "us-east-1"
  profile = "eric"
}
EOL
)

# Append the Terraform configuration to the file
echo "$TERRAFORM_CONFIG" >> provider.tf

echo "Terraform configuration appended to provider.tf."
