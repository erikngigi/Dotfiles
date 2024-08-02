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

	# Define an array of module names
	modules=(
		"containers"
		"instances"
		"database"
		"management"
		"network"
		"notifications"
		"scaling"
		"security"
		"severless"
		"storage"
	)

	# Define an array of module filenames to create
	module_files=(
		"main.tf"
		"outputs.tf"
		"variables.tf"
		"provider.tf"
	)

	# Define an array of root filenames to create
	root_files=(
		"main.tf"
		"outputs.tf"
		"variables.tf"
		"provider.tf"
		"terraform.tfvars"
		".gitignore"
	)

	# Create the files in the root directory
	for file in "${root_files[@]}"; do
		root_name="$root_directory"
		if [ ! -d "$root_name" ]; then
			mkdir -p "$root_name"
		fi
		touch "$root_name/$file"
	done

	# Create the directories and files in each module
	for module in "${modules[@]}"; do
		module_dir="$root_directory/modules/$module"
		mkdir -p "$module_dir"
		for file in "${module_files[@]}"; do
			touch "$module_dir/$file"
		done
	done
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
	# Define the templates
	local template_0="$HOME/.scripts/terraform/provider_template_0.txt"
	local template_1="$HOME/.scripts/terraform/provider_template_1.txt"

	# Check if the selected profile is 'localstack'
	if [[ "$aws_profile" == "localstack" ]]; then
		echo "Using localstack template: $template_0"
		cat "$template_0" >>"$root_directory_name/provider.tf"
	else
		echo "Using default template: $template_1"
		cat "$template_1" >>"$root_directory_name/provider.tf"
	fi
}

# terraform init function
terraform_initialize() {
	read -r -p "$terraform_init" terraform_answer
	case "$terraform_answer" in
	[yY] | [yY][eE][sS])
		if [[ -d "$root_directory_name" ]]; then
			cd "$root_directory_name" || exit

			if [[ "$aws_profile" == "localstack" ]]; then
				# If the selected profile is 'localstack', run 'tflocal init'
				echo -e "${GREEN}Running 'tflocal init' in the infrastructure directory...${RESET}"
				tflocal init
			else
				# If another profile is selected, run 'terraform init'
				echo -e "${GREEN}Running 'terraform init' in the infrastructure directory...${RESET}"
				terraform init
			fi
			echo
		else
			echo -e "${RED}The infrastructure directory does not exist. Skipping initialization....${RESET}"
			echo
		fi
		;;
	[nN] | [nN][oO])
		echo -e "${RED}Exiting without running initialization....${RESET}"
		echo
		exit 1
		;;
	*)
		echo -e "${RED}Invalid input. Exiting without running initialization....${RESET}"
		echo
		exit 1
		;;
	esac
}

populate_gitignore() {
	cat <<EOF >>"$root_directory_name/.gitignore"
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
}

main() {
	check_credentials_file
	welcome_message
	create_directory
	echo -e "${YELLOW}$aws_cli_profiles${RESET}"
	extract_profiles
	prompt_for_profile_selection
	populate_provider
	populate_gitignore
	terraform_initialize
}

# Execute main function
main
