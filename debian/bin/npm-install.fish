#!/usr/bin/env fish

sudo apt remove -y npm nodejs
curl -L git.io/nodebrew | perl - setup
~/.nodebrew/current/bin/nodebrew install-binary v18.1.0
~/.nodebrew/current/bin/nodebrew use v18.1.0
export PATH=$HOME/.nodebrew/current/bin:$PATH

set install_package \
    eslint \
    n8n \
    tern \
    typescript \
    typescript-language-server

~/.nodebrew/current/bin/npm install -g npm

for package in $install_package
    ~/.nodebrew/current/bin/npm install $package -g --unsafe-perm=true --allow-root
end
