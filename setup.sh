#!/bin/sh

FOLDER=$(pwd)

echo "Creating symbolic links to dotfiles..."
ln -sf $FOLDER/.zshrc ~/.zshrc
ln -sf $FOLDER/.gitconfig ~/.gitconfig
ln -sf $FOLDER/init.vim ~/.config/nvim/init.vim
ln -sf $FOLDER/coc-settings.json ~/.config/nvim/coc-settings.json

echo "Installing plugins for vim..."
if [ ! -e "$HOME/.vim/autoload/plug.vim" ]; then
    curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs \
        https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    vim +PlugInstall +qall
fi

curl -sL --proto-redir -all,https https://raw.githubusercontent.com/zplug/installer/master/installer.zsh | zsh

echo "Done! Enjoy the dotfiles!"
