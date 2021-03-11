#!/bin/bash

FOLDER=$(pwd)

echo "Creating symbolic links to dotfiles..."
ln -sf $FOLDER/.bashrc ~/.bashrc
ln -sf $FOLDER/.gitconfig ~/.gitconfig
ln -sf $FOLDER/.vimrc ~/.vimrc

echo "Installing plugins for vim..."
[ ! -e "$HOME/.vim/autoload/plug.vim" ] &&
    curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
        https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

vim +PlugInstall +qall
mkdir -p ~/.vim/undodir
mkdir -p ~/.config/coc/ultisnips
ln -sf $FOLDER/coc-settings.json ~/.vim/coc-settings.json
ln -sf $FOLDER/vim.snippets ~/.config/coc/ultisnips/vim.snippets

# get digestif for latex intellisense
if [ ! -e "$HOME/.local/bin/digestif" ]; then
    curl -fLo ~/.local/bin/digestif --create-dirs \
        https://raw.githubusercontent.com/astoff/digestif/master/scripts/digestif
    chmod +x ~/.local/bin/digestif
fi

if [ ! -e "$HOME/.local/share/fonts/Droid Sans Mono for Powerline Nerd Font Complete.otf" ]; then
    echo "Installing font for devicons..."
    curl -fLo "~/.local/share/fonts/Droid Sans Mono for Powerline Nerd Font Complete.otf" \ 
        https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/DroidSansMono/complete/Droid%20Sans%20Mono%20Nerd%20Font%20Complete.otf
            --create-dirs
    fc-cache -f -v
fi

echo "Done! Enjoy the dotfiles!"
