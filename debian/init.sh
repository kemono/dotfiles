#!/usr/bin/env bash

# setting authorized_keys
if [ ! -d ~/.ssh ]; then
    mkdir ~/.ssh
    chmod 700 ~/.ssh
fi

curl https://github.com/kemono.keys > ~/.ssh/authorized_keys
chmod 600 ~/.ssh/authorized_keys

if [ -e /usr/bin/apt ]; then
    # disable interactive
    export DEBIAN_FRONTEND=noninteractive

    # apt fix
    yes y | sudo -E apt --fix-broken install -y
    yes y | sudo -E apt -y install software-properties-common

    # first package install
    yes y | sudo -E apt -y update
    yes y | sudo -E apt -y upgrade
fi

# change login shell
sudo -E chsh -s $(which fish) $(whoami)

# disable login message
touch ~/.hushlogin

# windows drive remount
if [ -d /mnt/c ]; then
    sudo umount /mnt/c
    sudo mount -t drvfs C: /mnt/c -o metadata
fi

# download dotfiles
if [ ! -d ~/dotfiles ]; then
    if [ -d /mnt/c ]; then
        git clone --depth 1 https://github.com/kemono/dotfiles /mnt/c/dotfiles
        ln -s /mnt/c/dotfiles ~/dotfiles
        mkdir -p /mnt/c/projects
        ln -s /mnt/c/projects ~/projects
	chmod 700 ~/projects
    else
        git clone --depth 1 https://github.com/kemono/dotfiles ~/dotfiles
    fi
fi

# branch setting
cd ~/dotfiles
git config remote.origin.fetch '+refs/heads/*:refs/remotes/origin/*'

# main install
~/dotfiles/debian/main.fish
