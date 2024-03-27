# !/bin/sh

# autoload vsc and colors
autoload -Uz vcs_info
autoload -U colors && colors

# enable only git
zstyle ':vcs_info:*' enable git

# setup hook to run before every prompt 
precmd_vcs_info() { vcs_info }
precmd_functions+=( precmd_vcs_info )
setopt PROMPT_SUBST

# Enable checking for (un)staged changes, enabling use of %u and %c
zstyle ':vcs_info:git*+set-message:*' hooks git-untracked
+vi-git-untracked(){
    if [[ $(git rev-parse --is-inside-work-tree 2> /dev/null) == 'true' ]] && \
        git status --porcelain | grep '??' &> /dev/null ; then
        # This will show the marker if there are any untracked files in repo.
        # If instead you want to show the marker only if there are untracked
        # files in $PWD, use:
        #[[ -n $(git ls-files --others --exclude-standard) ]] ; then
        hook_com[staged]+='!' # signify new files with a bang
    fi
}
zstyle ':vcs_info:*' check-for-changes true
# zstyle ':vcs_info:git:*' formats " %F{48}(%F{1}%m%u%c%F{14}%F{48} %b%F{48})"
# zstyle ':vcs_info:git:*' formats " %F{1}%m%u%c%F{11}%F{11} %b"
zstyle ':vcs_info:git:*' formats " %F{250}%b%F{1}%m%u%c"
# PROMPT='%F{14}󰔛 %T%F{reset} %(?:%F{40}➜ :%F{1}➜ )%F{14}%~%F{reset}'
NEWLINE=$'\n'
PROMPT=' %F{14}%~%F{reset}'
PROMPT+="\$vcs_info_msg_0_ %F{reset} $NEWLINE%F{14}  %F{reset}"
