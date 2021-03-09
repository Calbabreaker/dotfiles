#!/bin/bash

[ $EUID -ne 0 ] && echo "Needs to be run as root!" && exit

# install apt packages
apt install -y ncdu xsel trash-cli
    
