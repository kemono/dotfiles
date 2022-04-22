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
    enum4linux \
    feroxbuster \
    ffmpeg \
    firewalld \
    fish \
    flex \
    g++ \
    gawk \
    gcc \
    gdb \
    gdebi \
    git \
    gobuster \
    gzip \
    htop \
    httpie \
    imagemagick \
    impacket-scripts \
    jq \
    libcurl4-openssl-dev \
    libfreetype6-dev \
    libgccjit-12-dev \
    libgccjit-8-dev \
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
    lolcat \
    lynx \
    make \
    mpv \
    nbtscan \
    ncrack \
    ncurses-dev \
    nikto \
    nkf \
    nmap \
    npm \
    onesixtyone \
    openssh-server \
    openvpn \
    oscanner \
    pkg-config \
    pv \
    python3-pip \
    redis-tools \
    screen \
    seclists \
    silversearcher-ag \
    sipvicious \
    smbclient \
    smbmap \
    snmp \
    software-properties-common \
    ssh \
    sslscan \
    sudo \
    task-japanese \
    texinfo \
    tnscmd10g \
    traceroute \
    vim \
    vuls \
    wget \
    whatweb \
    wkhtmltopdf \
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
