#!/usr/bin/env fish

set install_package \
    git+https://github.com/Tib3rius/AutoRecon.git \
    scrap_engine \
    speedtest-cli \
    youtube-dl

for package in $install_package
    sudo -EH pip3 install $package
    sudo -EH pip3 install --upgrade $package
end
