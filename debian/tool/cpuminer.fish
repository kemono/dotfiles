#!/usr/bin/env fish

mkdir -p ~/tmp/dotfiles/src
cd ~/tmp/dotfiles/src
git clone --depth 1 https://github.com/tpruvot/cpuminer-multi.git cpuminer-multi
cd cpuminer-multi
./build.sh
sudo make install
