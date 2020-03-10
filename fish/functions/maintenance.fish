function maintenance

    # ssh key update
    curl https://github.com/kemono.keys > ~/.ssh/authorized_keys
    chmod 600 ~/.ssh/authorized_keys

    # apt update
    sudo -E apt --fix-broken install -y
    sudo -E apt update -y
    sudo -E apt dist-upgrade -y
    sudo -E apt full-upgrade -y
    sudo -E apt clean -y
    sudo -E apt autoremove --purge -y

    # other system update
    omf update
    git -C ~/dotfiles fetch -p
    ~/dotfiles/debian/bin/pip-install.fish
    yes y | sudo -E lein upgrade
    lein ancient upgrade-profiles

    # remove unused files (home directory)
    rm -rf ~/tmp/dotfiles
    rm -rf ~/.bash_login
    rm -rf ~/.bash_logout
    rm -rf ~/.bash_profile
    rm -rf ~/.bashrc
    rm -rf ~/.profile
    rm -rf ~/.wgets-hosts
    rm -rf ~/.cache
    rm -rf ~/.gnupg
    rm -rf ~/.httpie
    rm -rf ~/.mozilla
    rm -rf ~/.mplayer
    rm -rf ~/.slime-history.eld
    rm -rf ~/.viminfo
    rm -rf ~/.sudo_as_admin_successful
    rm -rf ~/.python_history
    rm -rf ~/.bash_history
    rm -rf ~/.lesshst

    # other clean up
    mclean
    yes yes | history clear
end
