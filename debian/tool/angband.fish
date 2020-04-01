#!/usr/bin/env fish

mkdir -p ~/tmp/dotfiles/src
cd ~/tmp/dotfiles/src

git clone --depth 1 https://github.com/angband/angband
cd angband
./autogen.sh
./configure
make
sudo make install
sudo mv /usr/local/games/angband /usr/games
