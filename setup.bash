#!/bin/bash

FOLDER=$(pwd)

echo "Creating symbolic links to dotfiles..."
ln -sf $FOLDER/.bashrc ~/.bashrc
ln -sf $FOLDER/.gitconfig ~/.gitconfig
ln -sf $FOLDER/.vimrc ~/.vimrc

if [ -e "$HOME/.vim/autoload/plug.vim" ]; then
    echo "Plug for vim already installed"
else
    echo "Installing plugins for vim..."
    curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
fi

vim +PlugInstall +qall
mkdir -p ~/.vim/undodir
ln -sf $FOLDER/coc-settings.json ~/.vim/coc-settings.json

echo "Done! Enjoy the dotfiles!"
