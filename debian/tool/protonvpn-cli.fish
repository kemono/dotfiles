#!/usr/bin/env fish

mkdir -p ~/tmp/dotfiles/src
cd ~/tmp/dotfiles/src
wget https://protonvpn.com/download/protonvpn-stable-release_1.0.1-1_all.deb
sudo apt install ./protonvpn-stable-release_1.0.1-1_all.deb
sudo apt update -y
sudo apt install protonvpn-cli -y
