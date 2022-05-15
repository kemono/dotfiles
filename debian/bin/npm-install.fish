#!/usr/bin/env fish

set install_package \
    eslint \
    n8n \
    tern \
    typescript \
    typescript-language-server

for package in $install_package
    sudo -EH npm install $package -g --unsafe-perm=true --allow-root
end
