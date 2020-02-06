#!/usr/bin/env bash

mkdir -p /tmp/dotfiles/src
cd /tmp/dotfiles/src

wget https://nethack.org/download/3.6.1/nethack-361-src.tgz
tar zxvf ./nethack-361-src.tgz
cd nethack-3.6.1
wget https://osdn.net/projects/jnethack/downloads/71182/jnethack-3.6.1-0.4.diff.gz
zcat jnethack-3.6.1-0.4.diff.gz | patch -p1
find ./ -type f | xargs -i nkf -e -Lu --overwrite {};
cd sys/unix
sh setup.sh hints/linux
cd ../../
make all
make install
