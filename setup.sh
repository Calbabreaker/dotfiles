#!/bin/sh

FOLDER=$(pwd)

echo "Creating symbolic links to dotfiles..."
ln -sf $FOLDER/.zshrc ~/.zshrc
ln -sf $FOLDER/.gitconfig ~/.gitconfig
ln -sf $FOLDER/.vimrc ~/.vimrc
ln -sf $FOLDER/coc-settings.json ~/.vim/coc-settings.json
ln -sf $FOLDER/vim.snippets ~/.config/coc/ultisnips/vim.snippets

# installs omyzsh
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

echo "Installing plugins for vim..."
if [ ! -e "$HOME/.vim/autoload/plug.vim" ]; then
    curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
        https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    vim +PlugInstall +qall
fi

mkdir -p ~/.vim/undodir
mkdir -p ~/.config/coc/ultisnips

# get digestif for latex intellisense
if [ ! -e "$HOME/.local/bin/digestif" ]; then
    curl -fLo ~/.local/bin/digestif --create-dirs \
        https://raw.githubusercontent.com/astoff/digestif/master/scripts/digestif
    chmod +x ~/.local/bin/digestif
fi

if [ ! -e "$HOME/.local/share/fonts/Droid Sans Mono for Powerline Nerd Font Complete.otf" ]; then
    echo "Installing font for devicons..."
    curl -fLo ~/.local/share/fonts/Droid\ Sans\ Mono\ for\ Powerline\ Nerd\ Font\ Complete.otf --create-dirs \
        https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/DroidSansMono/complete/Droid%20Sans%20Mono%20Nerd%20Font%20Complete.otf 
    fc-cache -fv
    echo "Make sure to set the terminal font to the nerd font."
fi

echo "Done! Enjoy the dotfiles!"
