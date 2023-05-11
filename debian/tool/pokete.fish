#!/usr/bin/env fish

cd /usr/local/games
sudo git clone https://github.com/lxgr-linux/pokete.git --depth 10
cd pokete
sudo git fetch -p --depth 10
sudo git reset --hard origin/master
sudo ln -s /usr/local/games/pokete/pokete.py /usr/local/bin/pokete
