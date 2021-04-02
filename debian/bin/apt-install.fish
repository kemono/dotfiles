#!/usr/bin/env fish

# default package list
set install_packages \
    anacron \
    at \
    autoconf \
    automake \
    bison \
    build-essential \
    caca-utils \
    chromium-chromedriver \
    chromium-driver \
    clusterssh \
    cowsay \
    cpulimit \
    curl \
    default-jdk \
    default-jre \
    dnsutils \
    ffmpeg \
    firewalld \
    fish \
    flex \
    freeciv \
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
    libgmp-dev \
    libgnutls28-dev \
    libgtk2.0-dev \
    libjansson-dev \
    libjpeg-dev \
    libmagickwand-dev \
    libncurses-dev \
    libpng-dev \
    libsoil-dev \
    libssl-dev \
    libtiff-dev \
    libtool-dev \
    libx11-dev \
    libxpm-dev \
    locales-all \
    lynx \
    make \
    mpv \
    ncrack \
    ncurses-dev \
    nkf \
    nmap \
    npm \
    openssh-server \
    openvpn \
    pkg-config \
    pv \
    python3-pip \
    screen \
    silversearcher-ag \
    software-properties-common \
    speedtest-cli \
    ssh \
    sudo \
    task-japanese \
    texinfo \
    traceroute \
    vim \
    vuls \
    wget \
    zip \
    zlib1g-dev \
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
