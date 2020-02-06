#!/usr/bin/env fish

# project directory create
mkdir -p ~/projects

# package install
~/dotfiles/debian/bin/apt-install.fish
~/dotfiles/debian/bin/pip-install.fish
~/dotfiles/debian/bin/link.fish

# other tools install
~/dotfiles/debian/tool/jnethack.bash
~/dotfiles/debian/tool/pokemonsay.fish
~/dotfiles/debian/tool/wrk.fish
~/dotfiles/debian/tool/chafa.fish
~/dotfiles/debian/tool/sdl.fish
~/dotfiles/debian/tool/emacs.fish

# language install
~/dotfiles/debian/lang/lisp.fish
~/dotfiles/debian/lang/clojure.fish

# last settings
~/dotfiles/debian/bin/move-local-bin.fish
~/dotfiles/debian/shell/omf-install.fish
