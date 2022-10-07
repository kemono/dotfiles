# Install (Debian)

### Step 1: Add user

Login root, After Run this command.

    curl -L adduser.kemono.app | bash

### Step 2: Install softwares

Login gazelle, After Run this command.

    nohup bash -c 'curl -L init.kemono.app | bash' &

# Caution

This environment setup script has a process to automatically add my ssh public key.  
If you want it to work, please remove the added user's (gazelle) ssh key for safety.
