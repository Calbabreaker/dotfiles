# Dotfiles

Personal dot files (aka configuration files) for neovim, zsh, tmux, and alacritty

## Setup

First You need to have git add GNU stow installed. 

Then clone the repository:

```sh
git clone https://github.com/Calbabreaker/dotfiles ~/.dotfiles
```

Now you can individually choose to use the dotfiles (specified by a folder) like so:

```sh
stow -d ~/.dotfiles/ --no-folding zsh
```

Or everything:

```sh
stow -d ~/.dotfiles/ --no-folding */
```

To remove a dotfile:

```sh
stow -d ~/.dotfiles/ -D zsh
stow -d ~/.dotfiles/ -D */ # all of them
```
