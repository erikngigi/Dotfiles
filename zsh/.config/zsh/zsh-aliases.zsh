#!/bin/sh

alias zsh-update-plugins="find "$ZDOTDIR/plugins" -type d -exec test -e '{}/.git' ';' -print0 | xargs -I {} -0 git -C {} pull -q"
alias nvimrc='nvim ~/.config/nvim/'
alias zshrc='nvim ~/.config/zsh/'
alias clear-zsh='echo -n "" > /home/eric/.zsh_history'
alias zsh-colors='for i in {1..256}; do print -P "%F{$i}Color : $i"; done;'

# get fastest mirrors
alias mirror="doas reflector -f 30 -l 30 --number 10 --verbose --save /etc/pacman.d/mirrorlist"
alias mirrord="doas reflector --latest 50 --number 20 --sort delay --save /etc/pacman.d/mirrorlist"
alias mirrors="doas reflector --latest 50 --number 20 --sort score --save /etc/pacman.d/mirrorlist"
alias mirrora="doas reflector --latest 50 --number 20 --sort age --save /etc/pacman.d/mirrorlist"

# Colorize grep output (good for log files)
alias grep='grep --color=auto'
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'

# Tmux
alias tmux-restart='tmux kill-server && tmux'

# Changing "ls" to "exa"
alias ls='exa -al --color=always --group-directories-first' # my preferred listing
alias la='exa -a --color=always --group-directories-first'  # all files and dirs
alias ll='exa -l --color=always --group-directories-first'  # long format
alias lt='exa -aT --color=always --group-directories-first' # tree listing
alias l.='exa -a | egrep "^\."'

# pdf
alias pdf='evince'

# pacman and yay
alias Pacman='doas pacman'
alias refresh='doas pacman -Syyy'
alias pacsyu='doas pacman -Syu'                  # update only standard pkgs
alias pacsyyu='doas pacman -Syyu'                # Refresh pkglist & update standard pkgs
alias yaysua='yay -Sua --noconfirm'              # update only AUR pkgs (yay)
alias yaysyu='yay -Syu --noconfirm'              # update standard pkgs and AUR pkgs (yay)
alias parsua='paru -Sua --noconfirm'             # update only AUR pkgs (paru)
alias parsyu='paru -Syu --noconfirm'             # update standard pkgs and AUR pkgs (paru)
alias unlock='doas rm /var/lib/pacman/db.lck'    # remove pacman lock
alias cleanup='doas pacman -Rns $(pacman -Qtdq)' # remove orphaned packages

# Sudo
alias sudo='doas'

# NvChad
alias nv='nvim'
alias Nv='doas nvim'

# confirm before overwriting something
alias rm='rm -i'
alias cp='advcp -gu'
alias Cp='doas advcp -gu'
alias mv='advmv -gu'
alias Mv='doas advmv -gu'

# hugo server
alias hugo-server='hugo serve --noHTTPCache --ignoreCache --disableFastRender'

# bat
alias cat='bat'

#mpv
alias mpv-nv="mpv --vid=no"
alias play-720='mpv --ytdl-format="bestvideo[height<=?720][fps<=?30][vcodec^=avc1]+bestaudio/best"'
alias play-1080='mpv --ytdl-format="bestvideo[height<=?1080][fps<=?30][vcodec^=avc1]+bestaudio/best"'
alias k-pop='mpv --vid=no "https://www.youtube.com/playlist?list=PLlhlrF6zpj01PV6qkBItGubiz-Z0Eefci"'

#anime-cli
alias anime-cli='anipy-cli -D -o -q 1080'
alias anime-watch='anipy-cli -o -q 1080'

#directory shortcuts
alias ericngigi='cd $HOME/Projects/web-applications/ericngigi.com/'
alias homepage='cd $HOME/.surf/'

#xrandr brightness
alias br='xrandr --output VGA-0 --brightness '

# nnn
alias n='nnn -dr'
alias N='doas nnn -drx'

#brightness
alias set-br='doas set-brightness.sh'

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
alias pull='git pull origin'
alias push='git push origin'
alias stat='git status'  # 'status' is protected name so using 'stat' instead
alias tag='git tag'
alias newtag='git tag -a'
alias merge='git merge'
alias git-eric='https://github.com/ErikNgigi/'

# Vanaheim HDD
alias vanaheim='doas mount -t btrfs /dev/sdb1 /home/eric/Yggdrasil'
alias uvanaheim='doas umount /dev/sdb1 /home/eric/Yggdrasil'

# Flash Drive Mount
alias fdmount='doas mount /dev/sdb1 /home/eric/Yggdrasil'
alias ufdmount='doas umount /dev/sdb1 /home/eric/Yggdrasil'

# Youtube
alias yt='yt-dlp --config-location /home/eric/.config/yt-dlp/normal-config'
alias ytp='yt-dlp --config-location /home/eric/.config/yt-dlp/playlist-config'
alias yta='yt-dlp --config-location /home/eric/.config/yt-dlp/audio-config'
alias clear-yt='echo -n "" > /home/eric/.youtube.txt'
alias clear-pl='echo -n "" > /home/eric/.youtube.m3u'
alias youtube-download='yt -a /home/eric/.youtube.txt'

#Aria
alias clear-aria='echo -n "" > /home/eric/.aria2/input.conf'

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

# Anime Aliases
# ------------------------------------------------------------------------------------------------#
# Bleach
alias bleach="mpv --aid=1 --vid=1 $HOME/Tv-Shows/Anime/Bleach/"

# Other Aliases
# alias clear-buckets="aws s3 rm s3://b2voiprectest --recursive --endpoint-url=https://s3.us-west-000.backblazeb2.com --profile ericjohnson-backblaze-rw && aws s3 rm s3://voiprectest --recursive --endpoint-url=$BIFROST_ENDPOINT_URL --profile ericjohnson-bifrost-rw"

alias colormysql=$(echo -e 'mysql --prompt="\x1B[31m\\u\x1B[34m@\x1B[32m\\h\x1B[0m:\x1B[36m\\d>\x1B[0m "')
