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

if [ -e "$HOME/.local/share/fonts/Droid Sans Mono for Powerline Nerd Font Complete.otf" ]; then
    echo "Font already installed"
else
    echo "Installing font for devicons..."
    mkdir -p ~/.local/share/fonts
    pushd  ~/.local/share/fonts && curl -fLo "Droid Sans Mono for Powerline Nerd Font Complete.otf" https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/DroidSansMono/complete/Droid%20Sans%20Mono%20Nerd%20Font%20Complete.otf
    popd
    fc-cache -f -v
fi

echo "Done! Enjoy the dotfiles!"
