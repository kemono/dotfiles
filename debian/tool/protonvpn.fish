#!/usr/bin/env fish

mkdir -p ~/tmp/dotfiles/src
cd ~/tmp/dotfiles/src
wget https://repo.protonvpn.com/debian/dists/stable/main/binary-all/protonvpn-stable-release_1.0.3_all.deb
sudo apt install ./protonvpn-stable-release_1.0.3_all.deb
sudo apt update -y
sudo apt install -y protonvpn-stable-release
