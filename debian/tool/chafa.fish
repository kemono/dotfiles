#!/usr/bin/env fish

mkdir -p /tmp/dotfiles/src
cd /tmp/dotfiles/src
git clone --depth 1 https://github.com/hpjansson/chafa.git
cd chafa
./autogen.sh
make
sudo make install
