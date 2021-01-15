#!/usr/bin/env fish

sudo cp -f /home/gazelle/dotfiles/debian/etc/ntp.conf /etc/ntp.conf
sudo systemctl enable ntp
sudo systemctl restart ntp
