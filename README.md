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
stow */  ---This will stow everything within the directory---
``````

``````bash
stow zsh  ---This will only stow the zsh directory---
``````

## Installed Packages

The `programs` directory includes all packages currently installed in my Arch Linux Workstation.

- `aur.list` For AUR Packages
- `pacman.list` For the Pacman Packages

## doas Configuration

### Description

This is a sample doas configuration file for granting administrative privileges to non-root users on a Linux or BSD system. The doas command is a lightweight alternative to sudo, which allows users to execute commands as another user or the root user. By default, the doas configuration file is located at /etc/doas.conf.

### Usage

To use this doas configuration file, simply copy and paste the contents into your existing doas configuration file or create a new file at /etc/doas.conf. Be sure to replace the values in the file with your own user and command specifications.

### Configuration Option

The doas configuration file consists of simple user: command specifications that define which users are allowed to run which commands with elevated privileges. This file includes examples for allowing a user to execute specific commands as root.
This /etc/doas.conf works as expected for most CLI applications (specifically, those that either don't have configuration files or else
have a single root-owned configuration living outside of /home):

permit nopass keepenv eric

However, most GUI applications (more specifically, any application that saves configuration settings in /home/someuser/somewhere) need the HOME environmental variable to be that of the effective user. Some GUI applications rely on the USER variable to determine the effective user. In addition, in order for GUI applications to access the graphical environment, they need XAUTHORITY to be that of the logged-in user.

Something like this in /etc/doas.conf should work well for both CLI and GUI applications:

```
permit nopass keepenv setenv { USER=eric HOME=/home/eric XAUTHORITY=/home/eric/.Xauthority } eric
```

### Security Considerations

When granting administrative privileges to non-root users, it's important to carefully consider the security implications of each command specification in the doas configuration file. Be sure to thoroughly test and validate your configuration before deploying it in a production environment.
