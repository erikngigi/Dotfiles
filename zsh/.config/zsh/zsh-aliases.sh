#!/usr/bin/env bash

alias clear-zsh='echo -n "" > /home/eric/.zsh_history'
alias zsh-colors='for i in {1..256}; do print -P "%F{$i}Color : $i"; done;'

# terraform
alias tf='terraform'

# get fastest mirrors
alias mirror="doas reflector --country Kenya --latest 5 --protocol http --protocol https --sort rate --save /etc/pacman.d/mirrorlist"

# Colorize grep output (good for log files)
alias grep='grep --color=auto'
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'

# Tmux
alias tmux-restart='tmux kill-server && tmux'

alias ls='eza -al --color=always --group-directories-first' # all files and dirs

# pacman and yay
alias Pacman='doas pacman'
alias refresh='doas pacman -Syyy'
alias pacsyu='doas pacman -Syu'               # update only standard pkgs
alias pacsyyu='doas pacman -Syyu'             # Refresh pkglist & update standard pkgs
alias yaysua='yay -Sua --noconfirm'           # update only AUR pkgs (yay)
alias unlock='doas rm /var/lib/pacman/db.lck' # remove pacman lock
alias cleanup='yay -Rns $(yay -Qtdq)'         # remove orphaned packages
alias checkupdates='checkupdates && yay -Qua'
alias update-arch='yay -Syu --noconfirm'
alias clear-cache='pacman -Scc && yay -Scc --noconfirm'

# Infracost
alias infracost-breakdown='infracost breakdown --path . --show-skipped'

# Sudo
alias sudo='doas'

# NvChad
nvim_cd() {
  local target_dir="${1:-.}" # Default to current directory

  if [ ! -d "$target_dir" ]; then
    echo "Error: Directory '$target_dir' not found"
    return 1
  fi

  local current_dir="$(pwd)"
  cd "$target_dir" || return 1
  nvim "$@"
  cd "$current_dir"
}
alias configrc='nvim_cd ~/.config/'
alias nvimrc='nvim_cd ~/.config/nvim'
alias zshrc='nvim_cd ~/.config/zsh'
alias nv='nvim'
alias Nv='doas nvim'

# confirm before overwriting something
alias rm='rm -i'
alias cp='advcp -gu'
alias Cp='doas advcp -gu'
alias mv='advmv -gu'
alias Mv='doas advmv -gu'

# hugo server
alias hugo-serve='hugo serve --port 3000 --buildDrafts --noHTTPCache --ignoreCache --disableFastRender'
# alias hugo-serve='hugo serve --port 3000 --disableFastRender'
alias tina-serve='npx tinacms dev -c "hugo serve --port 3001 --buildDrafts --noHTTPCache --ignoreCache --disableFastRender"'

# bat
alias cat='bat'

#mpv
alias mpv-nv="mpv --vid=no"
alias k-pop='mpv --vid=no "https://www.youtube.com/playlist?list=PLlhlrF6zpj01PV6qkBItGubiz-Z0Eefci"'
alias getting-loose='mpv --vid=no "https://www.youtube.com/playlist?list=PLlhlrF6zpj02QWTFPIQ_aMs7I3hACMzqr"'

# nnn
alias n='nnn -dr'
alias N='doas nnn -drx'

#feh
alias feh-display='feh -d -.'

# git
alias addup='git add'
alias addall='git add .'
alias branch='git branch'
alias checkout='git checkout'
alias clone='git clone'
alias commit='git commit'
alias fetch='git fetch'
alias gstat='git status' # 'status' is protected name so using 'stat' instead
alias tag='git tag'
alias newtag='git tag -a'
alias merge='git merge'

# systemctl
alias sysstart='sudo systemctl start'
alias sysrestart='sudo systemctl restart'
alias sysstop='sudo systemctl stop'
alias sysstatus='sudo systemctl status'

# docker
alias docker-containers-all='docker ps -a --format "table {{.Names}}\t{{.Image}}\t{{.Status}}\t{{.Ports}}"'
alias docker-images-all='docker images --format "table {{.Repository}}\t{{.Tag}}\t{{.ID}}\t{{.Size}}"'
alias docker-compose-up='docker compose up -d'
alias dcupf='docker compose up -d && docker compose --follow logs'
alias docker-compose-down='docker compose down -v'
alias docker-remove-containers='docker rm $(docker ps -a -q)'
alias docker-remove-images='docker rmi $(docker images -a -q)'
alias docker-compose-build='docker compose up --build'
alias docker-start='docker start $(docker ps -a -q)'
alias docker-stop='docker stop $(docker ps -a -q)'
alias docker-prune='docker system prune --all'
alias docker-volume-prune='docker volume rm $(docker volume ls)'
alias docker-remove-dangling-images='docker rmi $(docker images -f "dangling=true" -q)'

# python django
alias python-makemigrations='python manage.py makemigrations'
alias python-migrate='python manage.py migrate'
alias python-collectstatic='python manage.py collectstatic'
alias python-createsuperuser='python manage.py createsuperuser'
alias python-runserver='python manage.py runserver'

# Add SSH keys
alias ssh-add-hetzner='ssh-add /home/eric/.ssh/hetzner'

# Vanaheim HDD
alias vanaheim-btrfs='doas mount -t btrfs /dev/sdb1 /home/eric/Yggdrasil'
alias vanaheim-ntfs='doas mount -t ntfs /dev/sdb1 /home/eric/Yggdrasil'
alias uvanaheim='doas umount /dev/sdb1 /home/eric/Yggdrasil'

# Flash Drive Mount
alias fdmount='doas mount /dev/sdb1 /home/eric/Yggdrasil'
alias ufdmount='doas umount /dev/sdb1 /home/eric/Yggdrasil'

# Youtube
alias yt='yt-dlp --config-location /home/eric/.config/yt-dlp/normal-config'
alias ytp='yt-dlp --config-location /home/eric/.config/yt-dlp/playlist-config'
alias ytpv='yt-dlp --config-location /home/eric/.config/yt-dlp/private-config'
alias yta='yt-dlp --config-location /home/eric/.config/yt-dlp/audio-config'
alias clear-yt='echo -n "" > /home/eric/.youtube.txt'
alias clear-pl='echo -n "" > /home/eric/.youtube.m3u'
alias youtube-download='yt -a /home/eric/.youtube.txt'

# Aria
alias clear-aria='echo -n "" > /home/eric/.aria2/input.conf'

# Tremc
alias tremc='tremc -X'

# easier to read disk
alias df='df -h'     # human-readable sizes
alias free='free -m' # show sizes in MB

# display off
alias screenoff='xset dpms force off && betterlockscreen -l'
alias sleep='doas systemctl suspend && betterlockscreen -l'

# get top process eating memory
alias psmem='ps auxf | sort -nr -k 4 | head -5'

# get top process eating cpu ##
alias pscpu='ps auxf | sort -nr -k 3 | head -5'

# gpg encryption
# verify signature for isos
alias gpg-check="gpg2 --keyserver-options auto-key-retrieve --verify"
# receive the key of a developer
alias gpg-retrieve="gpg2 --keyserver-options auto-key-retrieve --receive-keys"

# For when keys break
alias archlinx-fix-keys="sudo pacman-key --init && sudo pacman-key --populate archlinux && sudo pacman-key --refresh-keys"

# systemd
alias mach_list_systemctl="systemctl list-unit-files --state=enabled"

# Game mode
alias game-mode-on="xrandr --output DP-2 --off"
alias game-mode-off="xrandr --output DP-2 --mode 1920x1080 --left-of DP-1"
gaming() {
  local target_dir="${1:-.}" # Default to current directory

  if [ ! -d "$target_dir" ]; then
    echo "Error: Directory '$target_dir' not found"
    return 1
  fi

  cd "$target_dir"
}
alias fear3='gaming ~/.wine/my-games/drive_c/Program\ Files\ \(x86\)/WB\ Games/F.E.A.R.\ 3'
alias outland='gaming ~/.wine/my-games/drive_c/Program\ Files\ \(x86\)/Housemarque/Outland'
alias nfs-mw='gaming ~/.wine/my-games/drive_c/Program\ Files\ \(x86\)/R.G.\ Mechanics/Need\ for\ Speed\ -\ Most\ Wanted/'

# Anime
alias legend-of-the-galatic-heroes="mpv --aid=1 --sid=1 /storage/Tv-Shows/Anime/Legend\ of\ the\ Galatic\ Heroes/"
alias dr-stone="mpv /storage/Tv-Shows/Anime/Dr\ Stone"

# Western Tv-Shows
alias 1883="mpv /storage/Tv-Shows/Western/1883"
alias house-of-the-dragon="mpv /storage/Tv-Shows/Western/House\ of\ the\ Dragon"
alias my-adventures-with-superman="mpv /storage/Tv-Shows/Western/My\ Adventures\ With\ Superman"
alias star-wars-maul="mpv /storage/Tv-Shows/Western/Star\ Wars\ Maul\ -\ Shadow\ Lord"
alias the-wire="mpv /storage/Tv-Shows/Western/The\ Wire"
alias wolverine-and-the-xmen="mpv /storage/Tv-Shows/Western/Wolverine\ and\ the\ X-Men"
alias xmen-the-animated-series="mpv /storage/Tv-Shows/Western/X-Men\ The\ Animated\ Series"
alias xmen-97="mpv /storage/Tv-Shows/Western/X-Men\ 97"
