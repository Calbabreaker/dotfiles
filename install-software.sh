#!/bin/sh

# install apt packages
sudo apt install ncdu xsel trash-cli vim neofetch gpick xdotool vim-gtk zsh ranger bat silversearcher-ag

# get digestif for latex intellisense
curl -fLo ~/.local/bin/digestif --create-dirs \
    https://raw.githubusercontent.com/astoff/digestif/master/scripts/digestif
chmod +x ~/.local/bin/digestif

# install nvm
printf "Install nvm? [y/n]: "
read input
[ $input = "y" ] && 
    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.37.2/install.sh | bash || 
    echo "Abort nvm."
