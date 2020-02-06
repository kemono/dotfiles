#!/usr/bin/env fish

mkdir -p /tmp/dotfiles/src
cd /tmp/dotfiles/src
git clone --depth 1 https://github.com/wg/wrk.git wrk
cd wrk
make
sudo cp wrk /usr/local/bin
