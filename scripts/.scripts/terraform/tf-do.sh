#!/usr/bin/env bash

# break program if error is encountered
set -eo pipefail

# message display function
msg() {
	local text="$1"
	local div_width="100"
	printf "%${div_width}s\n" ' ' | tr ' ' -
	printf "%s\n" "$text"
}

# function to confirm user selection
confirm() {
	local question="$1"
	while true; do
		msg "$question"
		read -p "[y]es or [n]o (default: no) : " -r answer
		case "$answer" in
		y | Y | yes | Yes | YES)
			return 0
			;;
		n | N | no | No | *[[:blank:]]* | "")
			return 1
			;;
		*)
			msg "Please answer [y]es or [n]o"
			;;
		esac
	done
}

# function to check if terraform is installed and terraform version
check_terraform() {
	if command -v terraform &>/dev/null; then
		msg "Terraform is installed"
		terraform_version=$(terraform version -json | jq -r .terraform_version)
		echo "Terraform version $terraform_version"
	else
		echo "Terraform is not installed"
		exit 1
	fi
}

# function to check if doctl is installed and doctl version
check_doctl() {
	if command -v doctl &>/dev/null; then
		msg "DigitalOcean CLI in installed"
		doctl_version=$(doctl version | awk 'NR==1 {print $3}')
		echo "Doctl Version $doctl_version"
	else
		echo "Doctl is not installed"
		exit 1
	fi
}

# function to check if terraform digitalocean token environmental variable is set
check_doctl_env_token() {
	if [[ -z "${TF_VAR_do_token}" ]]; then
		echo "DigitalOcean Environmental Token is Missing"
	else
		echo "DigitalOcean Environmental Token is Set"
	fi
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
		"README.md"
	)

	# Define an array of root filenames to create
	root_files=(
		"main.tf"
		"outputs.tf"
		"variables.tf"
		"provider.tf"
		"terraform.tfvars"
		".gitignore"
		"README.md"
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

		# create sub-directory for templates
		templates_dir="$module_dir/templates"
		mkdir -p "$templates_dir"

		# create files for the modules
		for file in "${module_files[@]}"; do
			touch "$module_dir/$file"
		done
	done
}

create_terraform_infrastructure() {
	if confirm "Would you like to create your workspace in this directory"; then
		while true; do
			read -r -p "Enter the name of your workspace (no spaces allowed): " workspace_name
			# check if the workspace exist
			if [[ -d "$workspace_name" ]]; then
				echo "$workspace_name already exist"
				echo "Use another name"
			elif [[ ! "$workspace_name" =~ ^[a-zA-Z0-9_-]+$ ]]; then
				echo "Invalid workspace name."
			else
				directory_structure_template "$workspace_name"
				break
			fi
		done
	fi
}

provider_file_append() {
	# Define templates to use in the provider file
	local do_template="$HOME/.scripts/terraform/provider_template_2.txt"

	cat "$do_template" >>"$workspace_name/provider.tf"
}

gitignore_file_append() {
	# Define gitignore template
	local gitignore_template="$HOME/.scripts/terraform/gitignore.txt"

	# Check if the gitignore file exist
	if confirm "Would you like to initialize the gitignore file to improve your workspace security"; then
		if [[ -f "$workspace_name/.gitignore" ]]; then
			echo "Appending to the Gitignore file"
			echo "Using gitignore template: $gitignore_template"
			cat "$gitignore_template" >>"$workspace_name/.gitignore"
		else
			echo "No Gitignore file found"
			exit 1
		fi
	else
		echo "Option is Invalid. Kindly select the displayed profiles"
		gitignore_file_append
	fi
}

initialize_workspace() {
	if confirm "Would you like to initialize the directory with the required provider file"; then
		if [[ -d "$workspace_name" ]]; then
			cd "$workspace_name" || exit
			terraform init
		else
			echo "The workspace does not exit"
		fi
	else
		echo "Exiting application without performing initialization"
		exit 1
	fi
}

# function to display logo
print_logo() {
	cat <<'EOF'
   _____                    __                      ______                   _          _ 
|_   _|                  / _|                     |  _  \                 | |        | |
  | | ___ _ __ _ __ __ _| |_ ___  _ __ _ __ ___   | | | |___  ___ ___   __| | ___  __| |
  | |/ _ \ '__| '__/ _` |  _/ _ \| '__| '_ ` _ \  | | | / _ \/ __/ _ \ / _` |/ _ \/ _` |
  | |  __/ |  | | | (_| | || (_) | |  | | | | | | | |/ /  __/ (_| (_) | (_| |  __/ (_| |
  \_/\___|_|  |_|  \__,_|_| \___/|_|  |_| |_| |_| |___/ \___|\___\___/ \__,_|\___|\__,_|
                                                                                        

EOF
}

main() {
	print_logo
	msg "You are using Terraform Decoded: Optimizing your Development Environment"
	check_terraform
	check_doctl
	check_doctl_env_token
	create_terraform_infrastructure
	provider_file_append
	gitignore_file_append
	initialize_workspace
}

main "$@"
