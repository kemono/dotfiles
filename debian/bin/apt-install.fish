#!/usr/bin/env fish

# default package list
set install_packages \
anacron \
autoconf \
automake \
bison \
build-essential \
caca-utils \
chromium-chromedriver \
chromium-driver \
cowsay \
cpulimit \
curl \
default-jdk \
default-jre \
dnsutils \
ffmpeg \
fish \
flex \
g++ \
gawk \
gcc \
gdb \
gdebi \
git \
gzip \
htop \
httpie \
imagemagick \
jq \
libcurl4-openssl-dev \
libfreetype6-dev \
libgif-dev \
libglib2.0-dev \
libgnutls28-dev \
libgtk2.0-dev \
libjpeg-dev \
libmagickwand-dev \
libncurses-dev \
libpng-dev \
libsoil-dev \
libtiff-dev \
libtool-dev \
libx11-dev \
libxpm-dev \
lynx \
make \
mpv \
ncurses-dev \
nkf \
nmap \
npm \
pkg-config \
pv \
python3-pip \
screen \
silversearcher-ag \
speedtest-cli \
ssh \
texinfo \
traceroute \
vim \
zip \
zsh \
zstd

if [ -e /usr/bin/apt ]
    set -lx DEBIAN_FRONTEND noninteractive
    alias sudo-apt 'yes y | sudo -E apt -y'

    # apt update
    sudo-apt --fix-broken install -y
    sudo-apt update
    sudo-apt upgrade

    # run install
    for package in $install_packages
        sudo-apt install $package
    end
end
