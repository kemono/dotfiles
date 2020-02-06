#!/usr/bin/env fish

# make link
function ln-directory
    rm -rf $argv[1]
    ln -nfs $argv[2] $argv[1]
end

# home directory dotfiles
ln-directory ~/.emacs.d ~/dotfiles/.emacs.d
ln-directory ~/.gitconfig ~/dotfiles/.gitconfig
ln-directory ~/.sbclrc ~/dotfiles/.sbclrc
ln-directory ~/.nethackrc ~/dotfiles/.nethackrc

# fish shell
rm -rf ~/.config/fish/conf.d
ln-directory ~/.config/fish/config.fish ~/dotfiles/fish/config.fish
ln-directory ~/.config/fish/functions ~/dotfiles/fish/functions
