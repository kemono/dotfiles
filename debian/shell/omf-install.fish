#!/usr/bin/env fish

if [ -e /.local/share/omf ]
    echo 'oh-my-fish is installed'
else
    mkdir -p ~/tmp/dotfiles/src
    cd ~/tmp/dotfiles/src
    git clone --depth 1 https://github.com/oh-my-fish/oh-my-fish
    cd oh-my-fish
    bin/install --offline --noninteractive --yes
end
