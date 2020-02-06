#!/usr/bin/env bash

# add user
if [ ! -e /home/gazelle ]; then
    yes "" | adduser gazelle --disabled-login
fi

# Debian family
if [ -e /usr/bin/apt ]; then
    usermod -aG sudo gazelle
    timedatectl set-timezone Asia/Tokyo

    # current apt update
    apt update -y
    apt upgrade -y
    
    apt install -y sudo curl ssh openssh-server firewalld fish anacron git task-japanese locales-all
fi

# Japanese env setting
localectl set-locale LANG=ja_JP.UTF-8 LANGUAGE="ja_JP:ja"
source /etc/default/locale

# update sshd and sudoers setting
curl -L https://raw.githubusercontent.com/kemono/dotfiles/master/debian/etc/sudoers > /etc/sudoers
curl -L https://raw.githubusercontent.com/kemono/dotfiles/master/debian/etc/ssh/sshd_config > /etc/ssh/sshd_config

# ssh auth key setting
mkdir /home/gazelle/.ssh
chmod 700 /home/gazelle/.ssh
chown gazelle:gazelle /home/gazelle/.ssh
curl -L https://github.com/kemono.keys > /home/gazelle/.ssh/authorized_keys
chmod 600 /home/gazelle/.ssh/authorized_keys
chown gazelle:gazelle /home/gazelle/.ssh/authorized_keys

# firewall setting
firewall-cmd --permanent --remove-service=ssh
firewall-cmd --permanent --remove-service=dhcpv6-client
firewall-cmd --permanent --add-port=80/tcp

# service setting
systemctl enable sshd
systemctl enable anacron
systemctl enable firewalld

reboot
