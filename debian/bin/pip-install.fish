#!/usr/bin/env fish

set install_package \
    git+https://github.com/Tib3rius/AutoRecon.git \
    scrap_engine \
    speedtest-cli \
    yt-dlp

for package in $install_package
    sudo -EH pip3 install $package
    sudo -EH pip3 install --upgrade $package
end

# mvp settings
mkdir -p ~/.config/mpv
rm ~/.config/mpv/custom-mpv.conf
echo "script-opts=ytdl_hook-ytdl_path=yt-dlp" > ~/.config/mpv/custom-mpv.conf
