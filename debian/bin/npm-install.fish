#!/usr/bin/env fish

set install_package n8n typescript

for package in $install_package
    sudo -EH npm install $package -g --unsafe-perm=true --allow-root
end
