function unixbench
    mkdir -p /tmp/dotfiles/src
    cd /tmp/dotfiles/src
    git clone --depth 1 https://github.com/kdlucas/byte-unixbench.git
    cd ./byte-unixbench/UnixBench
    ./Run
end
