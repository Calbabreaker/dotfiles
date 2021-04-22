#!/bin/sh

FOLDER=$(pwd)

echo "Creating symbolic links to dotfiles..."
ln -sf $FOLDER/.zshrc ~/.zshrc
ln -sf $FOLDER/.gitconfig ~/.gitconfig
ln -sf $FOLDER/.vimrc ~/.vimrc
ln -sf $FOLDER/coc-settings.json ~/.vim/coc-settings.json

echo "Installing plugins for vim..."
if [ ! -e "$HOME/.vim/autoload/plug.vim" ]; then
    curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
        https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    vim +PlugInstall +qall
fi

curl -sL --proto-redir -all,https https://raw.githubusercontent.com/zplug/installer/master/installer.zsh | zsh

mkdir -p ~/.vim/undodir
mkdir -p ~/.config/coc/ultisnips

if [ ! -e "$HOME/.local/share/fonts/Droid Sans Mono for Powerline Nerd Font Complete.otf" ]; then
    echo "Installing font for devicons..."
    curl -fLo ~/.local/share/fonts/Droid\ Sans\ Mono\ for\ Powerline\ Nerd\ Font\ Complete.otf --create-dirs \
        https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/DroidSansMono/complete/Droid%20Sans%20Mono%20Nerd%20Font%20Complete.otf 
    fc-cache -fv
    echo "Make sure to set the terminal font to the nerd font."
fi

echo "Done! Enjoy the dotfiles!"
