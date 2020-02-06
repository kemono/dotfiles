#!/usr/bin/env fish

mkdir -p /tmp/dotfiles/src
cd /tmp/dotfiles/src
git clone --depth 1 http://github.com/possatti/pokemonsay
cd ./pokemonsay
./install.sh
