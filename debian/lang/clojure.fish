#!/usr/bin/env fish

sudo wget -O /usr/local/bin/lein https://raw.github.com/technomancy/leiningen/stable/bin/lein
sudo chmod +x /usr/local/bin/lein
/usr/local/bin/lein

rm -rf ~/.lein/profiles.clj
ln -nfs ~/dotfiles/.lein/profiles.clj ~/.lein/profiles.clj
