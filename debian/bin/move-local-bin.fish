#!/usr/bin/env fish

sudo chmod 755 ~/bin/*
sudo chown root:root ~/bin/*
sudo mv ~/bin/* /usr/local/bin
rm -rf ~/bin
