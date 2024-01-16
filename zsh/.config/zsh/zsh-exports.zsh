#!/bin/sh
HISTSIZE=10000
SAVEHIST=10000

export PATH="$HOME/.local/bin":$PATH
# export MANPAGER="sh -c 'col -bx | bat -l man -p'"
export MANWIDTH=999
export GEM_HOME="usr/lib/ruby/gems"
export PATH="$PATH:$GEM_HOME/bin"
export PATH=/usr/bin/python3:$PATH
# export PATH=~/.npm-global/bin:$PATH
export PATH=$HOME/.scripts:$PATH
# export PATH=$HOME/.miniconda/bin:$PATH
export PATH=$PATH:/usr/local/go/bin
# export GOROOT=/usr/local/go 
# export GOPATH=$HOME/.go 
# export PATH=$PATH:$GOROOT/bin:$GOPATH/bin
export FZF_DEFAULT_COMMAND='ag --hidden --ignore .git -g ""'
export NNN_PLUG='r:renamer'
export NNN_TRASH=1
export NNN_COLORS='#27272727'
export NNN_FCOLORS='c1e2272e006033f7c6d6abc4'
export NNN_BMS="a:$HOME/Tv-Shows/Anime;d:$HOME/Downloads;e:$HOME/Yggdrasil;t:$HOME/Downloads/Torrents;v:$HOME/Videos/"
