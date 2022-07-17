lsblk
ip a
nmtui
sudo pacman -Sy
cd Downloads/
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si PKGBUILD 
cd
rm -rf Downloads/yay/
sudo pacman -S ttf-bitstream-vera ttf-dejavu ttf-droid gnu-free-fonts ttf-liberation ttf-linux-libertine noto-fonts ttf-roboto ttf-ubuntu-family-font ttf-fira-mono ttf-jetbrains-mono noto-fonts-emoji
sudo pacman -S ttf-bitstream-vera ttf-dejavu ttf-droid gnu-free-fonts ttf-liberation ttf-linux-libertine noto-fonts ttf-roboto ttf-ubuntu-font-family ttf-fira-mono ttf-jetbrains-mono noto-fonts-emoji
sudo pacman -S xorg xorg-init bspwm sxhkd rofi feh picom alacritty zsh
sudo pacman -S xorg xorg-xinit bspwm sxhkd rofi feh picom alacritty zsh
sudo pacman -S mpv
sudo pacman -Qsq | grep mesa
lsblk
sudo mkdir /mnt/Vanaheim
sudo mount /dev/sdb1 /mnt/Vanaheim/
cd /mnt/Vanaheim/
ls
cd CrossFit\ Games/
ls
mpv Resurgence.mp4 
sudo pacman -Rcns pulseaudio
sudo pacman -R pulseaudio
mpv Resurgence.mp4 
sudo pacman -Qsq | grep pulse
sudo pacman -R libpulse
sudo pacman -Rdd libpulse
mpv Resurgence.mp4 
sudo pacman -S pipewire
sudo pacman -S pipewire-alsa pipewire-jack pipewire-pulse
mpv Resurgence.mp4 
mpv --no-config Resurgence.mp4 
sudo pacman -S mesa-vdpau
mpv Resurgence.mp4 
sudo pacman -S vlc
vlc Resurgence.mp4 
..
cd ..
ls
ls -al
cd
sudo umount /dev/sdb1 /mnt/Vanaheim/
sudo mount /dev/sdb1 /mnt/Vanaheim/
cd /mnt/Vanaheim/
ls -al
cd Linux01/
ls -al
sudo cp .xinitrc /home/eric/
cd .config/
ls
sudo cp alacritty/ bspwm/ picom/ rofi/ sxhkd/ yt-dlp/ zsh/ /home/eric/.config/
sudo cp -r alacritty/ bspwm/ picom/ rofi/ sxhkd/ yt-dlp/ zsh/ /home/eric/.config/
cd ..
cp .zshrc /home/eric/
cd
startx
vim .xinitrc 
cd /mnt/Vanaheim/Linux01/
sudo cp .xinitrc.copy /home/eric/
cd
rm -rf .xinitrc
mv .xinitrc.copy xinitrc
vim .xinitrc
ls -al
vim xinitrc 
sudo chown -R eric:eric *
ls -al
mv xinitrc .xinitrc
vim .xinitrc 
startx
cd /mnt/Vanaheim/
cd Anime\ Movies/
cd Anime\ English\ Translated/
ls
cd Dragon\ Ball\ Super/
ls
mpv --hwdec=auto Movie\ 
mpv --hwdec=auto Movie\ 1\ \(2013\)/
mpv --hwdec=auto Movie\ 1\ \(2013\)/
mpv --hwdec=auto Movie\ 1\ \(2013\)/
vainfo
vdpauinfo
ffmpeg Movie\ 1
mpv Movie\ 1
ls -al
ffmpeg Movie\ 1\ \(2013\)/
mpv Movie\ 1\ \(2013\)/
mpv --hwdec=auto Movie\ 1\ \(2013\)/
mpv --hwdec=auto-copy-safe Movie\ 1\ \(2013\)/
mpv --hwdec=auto-copy-safe Movie\ 1\ \(2013\)/
mpv --hwdec=vaapi Movie\ 1\ \(2013\)/
mpv Movie\ 1\ \(2013\)/
mpv --hwdec=vdpau Movie\ 1\ \(2013\)/
mpv --hwdec=vaapi Movie\ 1\ \(2013\)/
mpv --hwdec=vaapi Movie\ 1\ \(2013\)/
sudo pacman -S libva-utils
vainfo
sudo pacman -S vdpauinfo
vdpauinfo
grep -iE 'vdpau | dri driver' .local/share/xorg/Xorg.0.log
sudo pacman -S libva-vdpau-driver
sudo dmesg | grep drm
sudo pacman -S libvdpau-va-gl
/usr/lib/dri/
sudo vim /etc/pacman.conf 
sudo pacman -Syyy
sudo pacman -S lib32-mesa-vdpau
sudo pacman -S libva-mesa-driver
vainfo
