export ZDOTDIR=$HOME/.config/zsh
source "$HOME/.config/zsh/.zshrc"

autoload -U +X bashcompinit && bashcompinit
complete -o nospace -C /usr/bin/terramate terramate
