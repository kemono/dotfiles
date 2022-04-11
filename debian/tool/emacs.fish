#!/usr/bin/env fish

mkdir -p ~/tmp/dotfiles/src
cd ~/tmp/dotfiles/src
git clone --depth 1 -b emacs-27 https://github.com/emacs-mirror/emacs.git
cd emacs

./autogen.sh
./configure \
    --enable-link-time-optimization \
    --with-cairo \
    --with-gnutls \
    --with-mailutils \
    --with-modules \
    --with-native-compilation \
    --with-sound \
    --with-wide-int \
    --with-x-toolkit=no \
    --without-dbus \
    --without-gconf \
    --without-gsettings \
    --without-makeinfo \
    --without-pop \
    --without-toolkit-scroll-bars \
    --without-x \
    --without-xim

make
sudo make install
