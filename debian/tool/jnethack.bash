#!/usr/bin/env bash

mkdir -p ~/tmp/dotfiles/src
cd ~/tmp/dotfiles/src

git clone --depth 1 -b NetHack-3.6.6_Released https://github.com/NetHack/NetHack.git
cd NetHack
wget https://osdn.net/projects/jnethack/downloads/74756/jnethack-3.6.6-0.2.diff.gz
zcat jnethack-3.6.6-0.5.diff.gz | patch -p1
find ./ -type f | xargs -i nkf -e -Lu --overwrite {};
cd sys/unix
sh setup.sh hints/linux
cd ../../
make all
make install
