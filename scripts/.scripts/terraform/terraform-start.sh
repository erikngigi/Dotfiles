#!/bin/bash

# Define ANSI escape codes for colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
RESET='\033[0m' # Reset color to default

# Global variables
credentials_file="$HOME/.aws/credentials"
declare -a profile_names # Array to hold profile names

# Show user current working directory
lines="-----------------------------------------------------------------------------------------------------------------------------------------------------"

# Create New Directory prompt
new_directory="(1) Would you like to create a Terraform Directory in $(echo -e "${YELLOW}$(pwd)${RESET}")
[y]es or [n]o (default: no) : "

terraform_init="(2) Would you like to initialize the Terraform Directory 
[y]es or [n]o (default: no) : "

terraform_git_init="(3) Would you like to initialize a gitignore file in the Terraform Directory 
[y]es or [n]o (default: no) : "

aws_cli_profiles="Would you like to select a AWS profile to use in your Terraform Configuration"

welcome_message() {
	echo -e "${GREEN}$lines
Welcome to Terraform Decoded : A configuration script designed to automated the creating of a Robust and Modular Terraform Development Environment 
$lines${RESET}"
}

check_credentials_file() {
	if [ ! -f "$credentials_file" ]; then
		echo -e "${RED}AWS credentials file not found: $credentials_file${RESET}"
		exit 1
	fi
}

extract_profiles() {
	local i=1
	while read -r line; do
		profile_names[i]=$(echo "$line" | awk -F'[][]' '{print $2}')
		echo -e "${YELLOW}$i)${RESET} ${profile_names[i]}"
		((i++))
	done < <(awk '/^\[/{print}' "$credentials_file")
}

prompt_for_profile_selection() {
	local profile_count=${#profile_names[@]}
	local selection
	echo -n "Select an AWS profile by number (1-$profile_count): "
	read -r selection

	# Validate the selection
	if [[ $selection =~ ^[0-9]+$ ]] && ((selection >= 1 && selection <= profile_count)); then
		aws_profile=${profile_names[selection]}
		echo -e "Selected AWS profile: ${YELLOW}$aws_profile${RESET}"
	else
		echo -e "${RED}Invalid selection. Please try again.${RESET}"
		prompt_for_profile_selection
	fi
	echo
	echo $lines
}

directory_structure_template() {

	root_directory=$1
	# Create Documentation directory
	mkdir -p "$root_directory/documentation"

	# Create Environment directory
	# mkdir -p "$root_directory/environment/development"
	# mkdir -p "$root_directory/environment/staging"
	# mkdir -p "$root_directory/environment/production"

	# Create infrastructure directory
	mkdir -p "$root_directory/infrastructure/modules"

	# Create Media directory
	mkdir -p "$root_directory/files"

	# Create modules subdirectories
	mkdir -p "$root_directory/infrastructure/modules/containers"
	mkdir -p "$root_directory/infrastructure/modules/instances"
	mkdir -p "$root_directory/infrastructure/modules/database"
	mkdir -p "$root_directory/infrastructure/modules/management"
	mkdir -p "$root_directory/infrastructure/modules/network"
	mkdir -p "$root_directory/infrastructure/modules/notifications"
	mkdir -p "$root_directory/infrastructure/modules/scaling"
	mkdir -p "$root_directory/infrastructure/modules/security"
	mkdir -p "$root_directory/infrastructure/modules/storage"

	# Create templates subdirectories
	mkdir -p "$root_directory/infrastructure/modules/containers/templates"
	mkdir -p "$root_directory/infrastructure/modules/notifications/templates"
	mkdir -p "$root_directory/infrastructure/modules/security/templates"

	# Create main.tf, outputs.tf, variables.tf, and versions.tf files
	touch "$root_directory/infrastructure/main.tf"
	touch "$root_directory/infrastructure/outputs.tf"
	touch "$root_directory/infrastructure/variables.tf"
	touch "$root_directory/infrastructure/provider.tf"
	touch "$root_directory/infrastructure/terraform.tfvars"

	touch "$root_directory/infrastructure/modules/containers/main.tf"
	touch "$root_directory/infrastructure/modules/containers/outputs.tf"
	touch "$root_directory/infrastructure/modules/containers/variables.tf"
	touch "$root_directory/infrastructure/modules/containers/versions.tf"
	touch "$root_directory/infrastructure/modules/containers/templates/app.json.tpl"

	touch "$root_directory/infrastructure/modules/instances/main.tf"
	touch "$root_directory/infrastructure/modules/instances/outputs.tf"
	touch "$root_directory/infrastructure/modules/instances/variables.tf"
	touch "$root_directory/infrastructure/modules/instances/versions.tf"

	touch "$root_directory/infrastructure/modules/database/main.tf"
	touch "$root_directory/infrastructure/modules/database/outputs.tf"
	touch "$root_directory/infrastructure/modules/database/variables.tf"
	touch "$root_directory/infrastructure/modules/database/versions.tf"

	touch "$root_directory/infrastructure/modules/management/main.tf"
	touch "$root_directory/infrastructure/modules/management/outputs.tf"
	touch "$root_directory/infrastructure/modules/management/variables.tf"
	touch "$root_directory/infrastructure/modules/management/versions.tf"

	touch "$root_directory/infrastructure/modules/network/main.tf"
	touch "$root_directory/infrastructure/modules/network/outputs.tf"
	touch "$root_directory/infrastructure/modules/network/variables.tf"
	touch "$root_directory/infrastructure/modules/network/versions.tf"

	touch "$root_directory/infrastructure/modules/notifications/main.tf"
	touch "$root_directory/infrastructure/modules/notifications/outputs.tf"
	touch "$root_directory/infrastructure/modules/notifications/variables.tf"
	touch "$root_directory/infrastructure/modules/notifications/versions.tf"
	touch "$root_directory/infrastructure/modules/notifications/templates/email-sns-stack.json.tpl"

	touch "$root_directory/infrastructure/modules/scaling/main.tf"
	touch "$root_directory/infrastructure/modules/scaling/outputs.tf"
	touch "$root_directory/infrastructure/modules/scaling/variables.tf"

	touch "$root_directory/infrastructure/modules/security/main.tf"
	touch "$root_directory/infrastructure/modules/security/outputs.tf"
	touch "$root_directory/infrastructure/modules/security/variables.tf"
	touch "$root_directory/infrastructure/modules/security/versions.tf"
	touch "$root_directory/infrastructure/modules/security/templates/ecs-ec2-role-policy.json.tpl"
	touch "$root_directory/infrastructure/modules/security/templates/ecs-ec2-role.json.tpl"
	touch "$root_directory/infrastructure/modules/security/templates/ecs-service-role.json.tpl"

	touch "$root_directory/infrastructure/modules/storage/main.tf"
	touch "$root_directory/infrastructure/modules/storage/outputs.tf"
	touch "$root_directory/infrastructure/modules/storage/variables.tf"
	touch "$root_directory/infrastructure/modules/storage/versions.tf"
}

# (Functions like create_directory_structure, configure_terraform_provider, etc., remain unchanged.)
create_directory() {
	read -r -p "$new_directory" answer
	case "$answer" in
	[yY] | [yY][eE][sS])
		# Prompt the user until a valid directory name is provided
		while true; do
			read -r -p "Enter the root directory name (no spaces, only hyphens or underscores allowed): " root_directory_name
			# Check if directory already exists
			if [[ -d "$root_directory_name" ]]; then
				echo -e "${RED}Directory '$root_directory_name' already exists. Please enter a new directory name.${RESET}"
			# Check if directory name contains only allowed characters
			elif [[ ! "$root_directory_name" =~ ^[a-zA-Z0-9_-]+$ ]]; then
				echo -e "${RED}Invalid directory name. Only letters, numbers, hyphens (-), and underscores (_) are allowed.${RESET}"
			else
				directory_structure_template "$root_directory_name"
				break
			fi
		done
		;;
	[nN] | [nN][oO])
		echo -e "${RED}Exiting without creating a root directory.${RESET}"
		exit 1
		;;
	*)
		echo -e "${RED}Invalid input. Exiting without creating a root directory.${RESET}"
		exit 1
		;;
	esac
	echo -e "${GREEN}Directory structure created successfully.${RESET}"
  echo
	echo -e "${GREEN}$lines${RESET}"
}

populate_provider() {

	# Append provider information to provider.tf
	cat <<EOF >>"$root_directory_name/infrastructure/provider.tf"
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
  shared_config_files      = ["~/.aws/config"]
  shared_credentials_files = ["~/.aws/credentials"]
  profile                  = "$aws_profile"
}
EOF
}

# terraform init function
terraform_initialize() {
	read -r -p "$terraform_init" terraform_answer
	case "$terraform_answer" in
	[yY] | [yY][eE][sS])
		if [[ -d "$root_directory_name/infrastructure" ]]; then
			cd "$root_directory_name/infrastructure" || exit
			echo -e "${GREEN}Running 'terraform init' in the infrastructure directory...${RESET}"
			terraform init
			echo
		else
			echo -e "${GREEN}The infrastructure directory does not exist. Skipping 'terraform init'....${RESET}"
			echo
		fi
		;;
	[nN] | [nN][oO])
		echo -e "${RED}Exiting without running 'terraform init'....${RESET}"
		echo
		exit 1
		;;
	*)
		echo -e "${RED}Invalid input. Exiting without running 'terraform init'...${RESET}"
		echo
		exit 1
		;;
	esac

	# move one directory out
	cd ..

	echo -e "${GREEN}$lines${RESET}"

	read -r -p "$terraform_git_init" terraform_git_answer

	case "$terraform_git_answer" in
	[yY] | [yY][eE][sS])
		# User answered yes
		touch ".gitignore"

		cat <<EOF >>".gitignore"
# Local .terraform directories
**/.terraform/*

# .tfstate files
*.tfstate
*.tfstate.*

# Crash log files
crash.log
crash.*.log

# Exclude all .tfvars files, which are likely to contain sensitive data, such as
# password, private keys, and other secrets. These should not be part of version 
# control as they are data points which are potentially sensitive and subject 
# to change depending on the environment.
*.tfvars
*.tfvars.json

# Ignore override files as they are usually used to override resources locally and so
# are not checked in
override.tf
override.tf.json
*_override.tf
*_override.tf.json

# Include override files you do wish to add to version control using negated pattern
# !example_override.tf

# Include tfplan files to ignore the plan output of command: terraform plan -out=tfplan
# example: *tfplan*

# Ignore CLI configuration files
.terraformrc
terraform.rc
EOF

		echo

		echo -e "${GREEN}File created and information appended....${RESET}"
		;;
	[nN] | [nN][oO])
		# User answered no
		echo -e "${RED}Exiting without adding the '.gitignore' file....${RESET}"
		;;
	*)
		# Invalid input
		echo -e "${RED}Invalid input. Exiting without adding the '.gitignore' file....${RESET}"
		;;
	esac

	echo -e "${GREEN}$lines${RESET}"
}

main() {
	check_credentials_file
	welcome_message
	create_directory
	echo -e "${YELLOW}$aws_cli_profiles${RESET}"
	extract_profiles
	prompt_for_profile_selection
	populate_provider
	terraform_initialize
}

# Execute main function
main
