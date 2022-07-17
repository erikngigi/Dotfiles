# Dotfiles

![Arch Linux](./dotfiles.png)

## Installation

Before advancing ensure you have installed ```git``` and GNU ```stow``` on your workstation. 

Clone into your ```$HOME``` directory or ```~```. 

``````bash
https://github.com/ErikNgigi/Dotfiles.git
``````

Then run the ```stow``` to symlink everything or just select folders

``````bash
stow */  ---This will stow everything in the directory---
``````

``````bash
stow zsh  ---This will only stow the zsh directory---
``````

## Installed Packages

The `programs` directory includes all packages currently installed in my Arch Linux Workstation.

- `aur.list` For AUR Packages
- `pacman.list` For the Pacman Packages
