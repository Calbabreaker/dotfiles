#!/bin/bash

[ $EUID -ne 0 ] && echo "Needs to be run as root!" && exit

# install apt packages
apt install -y \
    ncdu # list files and directories sizes in terminal
    
