#!/usr/bin/env fish

set install_package \
    github.com/golang/lint/golint \
    github.com/kisielk/errcheck \
    github.com/nsf/gocode \
    github.com/rogpeppe/godef

for package in $install_package
    go get -u $package
end
