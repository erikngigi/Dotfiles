#!/usr/bin/env bash

# Paths
# Local bin
export PATH="$HOME/.local/bin:$PATH"

# Neovim Pre-Built Archives
export PATH="/opt/nvim/bin:$PATH"

# NodeJS global packages
# export PATH="$HOME/.npm-global/bin:$PATH"

# Go
export GOENV="$HOME/.go/env"
export GOPATH="$HOME/.go"
export GOBIN="$GOPATH/bin"
export PATH="$GOENV:$GOBIN:$PATH"

# Lua
export PATH="$HOME/.luarocks/bin:$PATH"

# Rust/Cargo
export PATH="$HOME/.cargo/bin:$PATH"

# Custom scripts
export PATH="$HOME/.scripts:$HOME/.scripts/terraform:$PATH"

# Flutter
export PATH="$HOME/.local/bin/flutter/bin:$PATH"

# Android SDK
export ANDROID_HOME="$HOME/.local/bin/android-sdk"
export PATH="$ANDROID_HOME/cmdline-tools/latest/bin:$PATH"
export PATH="$ANDROID_HOME/platform-tools:$PATH"

# Java Home
export JAVA_HOME="/usr/lib/jvm/java-26-openjdk"
export PATH="$JAVA_HOME/bin:$PATH"

# Mason (Neovim)
export PATH="$HOME/.local/share/nvim/mason/bin:$PATH"

# Custom Conda Tweaks
export CONDA_MAX_THREADS=4

# Pager & Man
export MANPAGER="sh -c 'col -bx | bat -l man -p'"
export MANROFFOPT="-c"
export MANWIDTH="${COLUMNS:-120}"

# FZF & NNN (CLI Tools)
export FZF_DEFAULT_COMMAND='ag --hidden --ignore .git -g ""'
export NNN_PLUG='r:renamer'
export NNN_TRASH=1
export NNN_COLORS='#27272727'
export NNN_FCOLORS='c1e2272e006033f7c6d6abc4'
export NNN_BMS="d:/storage/Downloads;e:/storage/Tv-Shows;h:$HOME/;m:/storage/Movies;t:/storage/Torrents;s:/storage/;y:$HOME/Yggdrasil"

# Editor & Browser
export EDITOR="/opt/nvim/bin/nvim"
export BROWSER="/usr/bin/brave"

# Terminal
[[ -z "$TMUX" ]] && export TERM="xterm-256color"

# XDG
# User directories
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_STATE_HOME="$HOME/.local/state"

# System directories
export XDG_DATA_DIRS="/usr/local/share:/usr/share"

# System
export SSH_AUTH_SOCK="${XDG_RUNTIME_DIR}/ssh-agent.socket"
export _JAVA_AWT_WM_NONREPARENTING=1

# Password manager
export PASSWORD_STORE_CLIP_TIME="120"

# Infracost
export INFRACOST_CURRENCY="USD"
export INFRACOST_CURRENCY_FORMAT="USD: $ 1,234.56"
export INFRACOST_LOG_LEVEL="info"

# Terraform
export TF_PLUGIN_CACHE_DIR="$HOME/.terraform.d/plugin-cache"

# Disable Python Prompt
export VIRTUAL_ENV_DISABLE_PROMPT=1
