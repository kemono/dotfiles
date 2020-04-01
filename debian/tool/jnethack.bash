#!/usr/bin/env bash

mkdir -p ~/tmp/dotfiles/src
cd ~/tmp/dotfiles/src

wget https://nethack.org/download/3.6.2/nethack-362-src.tgz
tar zxvf ./nethack-362-src.tgz
cd nethack-3.6.2
wget https://osdn.net/projects/jnethack/downloads/72026/jnethack-3.6.2-0.1.diff.gz
zcat jnethack-3.6.2-0.1.diff.gz | patch -p1
find ./ -type f | xargs -i nkf -e -Lu --overwrite {};
cd sys/unix
sh setup.sh hints/linux
cd ../../
make all
make install
