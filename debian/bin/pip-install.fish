#!/usr/bin/env fish

set install_package youtube-dl protonvpn-cli

for package in $install_package
    sudo -EH pip3 install $package
    sudo -EH pip3 install --upgrade $package
end
