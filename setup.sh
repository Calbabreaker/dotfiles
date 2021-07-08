#!/bin/sh

FOLDER=$(realpath `dirname $0`)

echo "Creating symbolic links to dotfiles..."
ln -sf $FOLDER/.zshrc ~/.zshrc
ln -sf $FOLDER/.gitconfig ~/.gitconfig

mkdir -p ~/.config/nvim/
ln -sf $FOLDER/.config/nvim/init.vim ~/.config/nvim/init.vim
ln -sf $FOLDER/.config/nvim/coc-settings.json ~/.config/nvim/coc-settings.json

mkdir -p ~/.config/alacritty/
ln -sf $FOLDER/.config/alacritty/alacritty.yml ~/.config/alacritty/alacritty.yml

echo "Installing plug for vim..."
if [ ! -e "$HOME/.vim/autoload/plug.vim" ]; then
    curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs \
        https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
fi

echo "Done! Enjoy the dotfiles!"
