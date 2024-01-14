#!/bin/bash

IS_GO_INSTALLED=$(which go)
GO_VERSION=1.20

# Changing following vars can broke script
OS=linux
CPU_ARCH=amd64
EXT=tar.gz

# Go file name and Download ADDRESS
GO_FILE="go${GO_VERSION}.${OS}-${CPU_ARCH}.${EXT}"
GO_DOWNLOAD="https://go.dev/dl/${GO_FILE}"

# IF YOU WANT UPDATED YOUR INSTALATION
# COMMENT FOLLOWING IF CONDITION
if [[ "${IS_GO_INSTALLED}" != "" ]]; then
	echo "Go already installed"
	exit 0
fi

DOWNLOAD_PATH="${HOME}/Downloads/golang"

function download {
	if [ ! -d "${DOWNLOAD_PATH}" ]; then
		mkdir -p "${DOWNLOAD_PATH}"
	fi

	wget -O "${DOWNLOAD_PATH}/${GO_FILE}" "${GO_DOWNLOAD}"
}

GO_ROOT="/usr/local/go"
GO_PATH="${HOME}/go"

function install {
	sudo rm -rf "${GO_ROOT}"
	sudo tar -C "/usr/local" -xzf "${DOWNLOAD_PATH}/${GO_FILE}"
	echo "You should do following steps:"
	printf "\tAdd the following lines to your [%s] or [%s]\n" "${HOME}/.profile" "/etc/profile"
	printf "\texport PATH=\$PATH:${GO_ROOT}/bin"
	printf "\n\n\tIn Arch Linux RUN:\n\tset --path %s\n" "${GO_ROOT}/bin"
	INSTALLED=$(which go)

	if [[ "${INSTALLED}" != "" ]]; then
		echo ""
		echo "Go installed!"
		echo "Installing golang server"
		go install golang.org/x/tools/gopls@latest
		echo ""
		echo "Go fully installed!"
		go version
	fi
}

function clear {
	if [ -e "${DOWNLOAD_PATH}/${GO_FILE}" ]; then
		rm -rf "${DOWNLOAD_PATH}"
	fi
}

download
install
clear
