#!/usr/bin/env fish

mkdir -p /tmp/dotfiles/src
cd /tmp/dotfiles/src

wget https://www.libsdl.org/release/SDL2-2.0.10.tar.gz
tar xvfz SDL2-2.0.10.tar.gz
cd SDL2-2.0.10
./configure
make
sudo make install
