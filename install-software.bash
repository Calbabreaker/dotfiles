#!/bin/bash

[ $EUID -ne 0 ] && echo "Needs to be run as root!" && exit

# install apt packages
apt install ncdu xsel trash-cli vim neofetch gpick pass
    
# install nvm
printf "Install nvm? [y/n]: "
read input
[ $input = "y" ] && curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.37.2/install.sh | bash
