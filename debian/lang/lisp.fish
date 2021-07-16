#!/usr/bin/env fish

mkdir -p ~/tmp/dotfiles/src
cd ~/tmp/dotfiles/src

set latest_version 2.1.6

set current_version ""
if test -e /usr/local/bin/sbcl
    set current_version (sbcl --version | string split " ")[2]
end

# Only run if version changes
if test $latest_version != $current_version
    wget -nc http://prdownloads.sourceforge.net/sbcl/sbcl-$latest_version-x86-64-linux-binary.tar.bz2
    tar xf sbcl-$latest_version-x86-64-linux-binary.tar.bz2
    cd sbcl-$latest_version-x86-64-linux
    sudo sh ./install.sh
end

# install quicklisp
if [ ! -d ~/quicklisp ]
    mkdir -p ~/tmp/dotfiles/src/ql
    cd ~/tmp/dotfiles/src/ql
    curl -O http://beta.quicklisp.org/quicklisp.lisp
    echo | sbcl --load quicklisp.lisp --eval "(quicklisp-quickstart:install)"
end

rm -rf ~/quicklisp/local-projects
ln -nfs ~/projects ~/quicklisp/local-projects
