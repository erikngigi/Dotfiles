export ZVM_CURSOR_STYLE_ENABLED=false
function zle-keymap-select {
  if [[ ${KEYMAP} == vicmd ]] || [[ $1 = 'block' ]]; then
    # Blinkinf block
    echo -ne '\e[2 q'
  elif [[ ${KEYMAP} == main ]] || [[ ${KEYMAP} == viins ]] || [[ ${KEYMAP} = '' ]] || [[ $1 = 'beam' ]]; then
    echo -ne '\e[6 q'
  fi
}

zle -N zle-keymap-select

# keybindings
bindkey '^A' beginning-of-line
bindkey '^E' end-of-line
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down
