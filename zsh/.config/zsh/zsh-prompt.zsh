# !/bin/sh

# autoload vsc and colors
autoload -Uz vcs_info
autoload -U colors && colors

# enable only git
zstyle ':vcs_info:*' enable git

precmd() {
    vcs_info
    prompt_git
    prompt_conda
}

setopt PROMPT_SUBST

prompt_git() {
    if [[ -n ${vcs_info_msg_0_} ]]; then
        GIT_STATUS=$(command git status --porcelain 2> /dev/null | tail -n1)
        GIT_BRANCH=$(git symbolic-ref HEAD | sed 's!refs\/heads\/!!')
        if [[ -n $GIT_STATUS ]]; then
            PROMPT_GIT_INFO=" :%F{1}$GIT_BRANCH%f "
        else
            PROMPT_GIT_INFO=" :%F{14}$GIT_BRANCH%f "
        fi
    else 
        PROMPT_GIT_INFO=""
    fi
}

prompt_conda() {
    if [[ -n $CONDA_DEFAULT_ENV ]]; then
        PROMPT_CONDA_ENV=" :%F{14}$CONDA_DEFAULT_ENV%f "
    else
        PROMPT_CONDA_ENV=""
    fi
}

NEWLINE=$'\n'
PROMPT='%F{14}[%F{14}%n%F{14}]%f %F{14}%~%f ${PROMPT_GIT_INFO}${PROMPT_CONDA_ENV}${NEWLINE}%F{14}%f '
