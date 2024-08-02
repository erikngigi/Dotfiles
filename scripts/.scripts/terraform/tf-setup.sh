#!/usr/bin/env bash

# break program if error is encountered
set -eo pipefail

# set up the local for the aws credentials file
declare -r aws_credentials_file="$HOME/.aws/credentials"

# index the profile names found in the credentials file
declare -a aws_profile_names

# message display function
function msg() {
	local text="$1"
	local div_width="100"
	printf "%${div_width}s\n" ' ' | tr ' ' -
	printf "%s\n" "$text"
}

function confirm() {
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
