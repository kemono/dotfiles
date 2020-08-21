#!/usr/bin/env fish

cd ~/projects
git clone --depth 1 https://github.com/borodust/trivial-gamekit.git trivial-gamekit
cd trivial-gamekit
git fetch -p --depth 1
