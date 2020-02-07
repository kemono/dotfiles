#!/usr/bin/env fish

mkdir -p /tmp/dotfiles/src
cd /tmp/dotfiles/src

curl https://sh.rustup.rs -sSf > bandwhich.bash
chmod 755 bandwhich.bash
./bandwhich.bash -y
~/.cargo/bin/cargo install bandwhich
