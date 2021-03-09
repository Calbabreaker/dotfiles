#!/bin/bash

[ $EUID -ne 0 ] && echo "Needs to be run as root!" && exit

# install apt packages
apt install -y ncdu xsel trash-cli
    
# install nvm
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.37.2/install.sh | bash
