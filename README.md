# Install (Debian)

### Step 1: Add user

Login root, After Run this command.

    curl -L raw.githubusercontent.com/kemono/dotfiles/master/debian/adduser.sh | bash

### Step 2: Install softwares

Login gazelle, After Run this command.

    nohup bash -c 'curl -L raw.githubusercontent.com/kemono/dotfiles/master/debian/init.sh | bash' &

# Caution

This environment setup script has a process to automatically add my ssh public key.  
If you want it to work, please remove the added user's (gazelle) ssh key for safety.
