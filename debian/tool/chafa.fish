#!/usr/bin/env fish

cd /usr/local/src
sudo git clone --depth 1 https://github.com/hpjansson/chafa.git
cd chafa
sudo git fetch -p
sudo git reset --hard origin/master
sudo ./autogen.sh
sudo make
sudo ln -nfs /usr/local/src/chafa/tools/chafa/chafa /usr/local/bin/chafa
