#!/usr/bin/env bash

create_user() {
	username=$1
	password=$2

	useradd -m -s /bin/bash "$username"

	echo "$username":"$password" | chpasswd

	echo "User '$username' has been created with password '$password'"

	usermod -aG sudo "$username"

	echo "User '$username' has been set with sudo privileges"
}

create_user tsrv tsrv123
