# Path Deduplication
# Must be set before any sources that modify PATH
typeset -U PATH path

# History
# HISTFILESIZE is a bash variabke and is ignored in zsh; use SAVEHIST instead
# These are zsh options, not env vars - no export needed
HISTFILESIZE=1000000
SAVEHIST=10000001
HISTFILE=~/.zsh_history
setopt HIST_FIND_NO_DUPS
setopt INC_APPEND_HISTORY
setopt HIST_IGNORE_SPACE
export ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE="20"
export ZSH_AUTOSUGGEST_USE_ASYNC=1

# Created by Zap installer
[ -f "${XDG_DATA_HOME:-$HOME/.local/share}/zap/zap.zsh" ] && source "${XDG_DATA_HOME:-$HOME/.local/share}/zap/zap.zsh"

# Plugins
# External community plugins load first
# NOTE: zsh-syntax-highlighting must remain last
plug "zap-zsh/supercharge"
plug "hlissner/zsh-autopair"
plug "zsh-users/zsh-history-substring-search"
# plug "zap-zsh/exa"
plug "zap-zsh/fzf"
plug "zsh-users/zsh-autosuggestions"
plug "macunha1/zsh-terraform"
plug "zsh-users/zsh-syntax-highlighting"

# Custom configurations come after community plugins
plug "$HOME/.config/zsh/zsh-exports.sh"
plug "$HOME/.config/zsh/zsh-functions.sh"
plug "$HOME/.config/zsh/zsh-prompt.sh"
plug "$HOME/.config/zsh/zsh-vim.sh"
plug "$HOME/.config/zsh/secrets.sh"
plug "$HOME/.config/zsh/zsh-aliases.sh"

# Load compinit
autoload -Uz compinit
if [[ -n $ZDOTDIR/.zcompdump(#qN.mh+24) ]]; then
  compinit # dump is stale — regenerate
else
  compinit -C # dump is fresh — skip audit, saves ~400ms
fi

autoload -Uz bashcompinit
bashcompinit

# Completion styles after compinit
zstyle ':completion:*' special-dirs false
zstyle ':completion::complete:*' use-cache 1

# Better SSH/Rsync/SCP Autocomplete
zstyle ':completion:*:(ssh|scp|rsync):*' tag-order 'hosts:-host:host'
zstyle ':completion:*:hosts-host' list-colors '=(#b)(*)( *)=00;34=00;31'
zstyle ':completion:*:nodes' ignored-patterns '*(.|:)*' loopback localhost
my_ssh_hosts=($([ -f ~/.ssh/config ] && grep -i "^Host" ~/.ssh/config | grep -v "[*?]" | awk '{print $2}'))
zstyle ':completion:*:hosts' hosts $my_ssh_hosts
zstyle ':completion:*:(ssh|scp|rsync):*:hosts-host' ignored-patterns '*(.|:)*' loopback ip6-loopback localhost ip6-localhost broadcasthost

# Better AWS completion
zstyle ':completion:*:aws:*' environment 'AWS_PROFILE' 'AWS_DEFAULT_REGION'

# AWS CLI completion in zsh
complete -C "/usr/local/bin/aws_completer" aws

# Terraform CLI completion in zsh
complete -o nospace -C "/usr/bin/terraform terraform"

# Autocomplete for usctl
_usctl() {
  local -a cmds
  cmds=(enable daemon-reload disable restart start stop status)

  if ((CURRENT == 2)); then
    # First arg: complete subcommands
    _describe 'command' cmds
  elif ((CURRENT == 3)); then
    # Second arg: complete service names
    local -a services
    services=($(systemctl --user list-unit-files --type=service --quiet | awk '{print $1}'))
    _describe 'service' services
  fi
}

# Autocomplete for ssctl
_ssctl() {
  local -a cmds
  cmds=(enable daemon-reload disable restart start stop status)

  if ((CURRENT == 2)); then
    # First arg: complete subcommands
    _describe 'command' cmds
  elif ((CURRENT == 3)); then
    # Second arg: complete service names
    local -a services
    services=($(systemctl list-unit-files --type=service --quiet | awk '{print $1}'))
    _describe 'service' services
  fi
}

compdef _usctl usctl
compdef _ssctl ssctl

# Add zoxide
eval "$(zoxide init --cmd cd zsh)"

# doctl — cache completion to avoid subprocess on every launch
# Run this once manually to generate: doctl completion zsh > ~/.config/zsh/doctl-completion.zsh
if [[ -f "$HOME/.config/zsh/doctl-completion.zsh" ]]; then
  source "$HOME/.config/zsh/doctl-completion.zsh"
else
  source <(doctl completion zsh)
fi

# pipx — cache completion similarly
# Run once: register-python-argcomplete pipx > ~/.config/zsh/pipx-completion.zsh
if [[ -f "$HOME/.config/zsh/pipx-completion.zsh" ]]; then
  source "$HOME/.config/zsh/pipx-completion.zsh"
else
  eval "$(register-python-argcomplete pipx)"
fi

# metatag — cache completion to avoid python subprocess forks on shell launch
if [[ -f "$HOME/.config/zsh/completions/metatag-completion.zsh" ]]; then
  source "$HOME/.config/zsh/completions/metatag-completion.zsh"
else
  eval "$(register-python-argcomplete metatag)"
fi

# NVM — lazy load (saves ~55ms; loads on first call to node/npm/nvm)
export NVM_DIR="$HOME/.nvm"
nvm() {
  unfunction nvm node npm npx yarn m2t
  [ -s "$NVM_DIR/nvm.sh" ] && source "$NVM_DIR/nvm.sh"
  [ -s "$NVM_DIR/bash_completion" ] && source "$NVM_DIR/bash_completion"
  nvm "$@"
}
node() {
  nvm
  node "$@"
}
npm() {
  nvm
  npm "$@"
}
npx() {
  nvm
  npx "$@"
}
yarn() {
  nvm
  yarn "$@"
}
m2t() {
  nvm
  m2t "$@"
}

# Custom Wine logger function
winelog() {
  WINEDEBUG="+all" wine "$@" >"$HOME/.wine_debug.log" 2>&1
}

# Confirm ssh-agent is running
if [ -z "$SSH_AUTH_SOCK" ]; then
  eval "$(ssh-agent -s)"
fi

# If tmux is executable, X is running, and not inside a tmux session, then try to attach. If attachment fails, start a new session
if [ -x "$(command -v tmux)" ] && [ -n "${DISPLAY}" ]; then
  [ -z "${TMUX}" ] && { tmux || tmux; } >/dev/null 2>&1
fi
