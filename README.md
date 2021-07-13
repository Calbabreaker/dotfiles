# Dotfiles

Personal dot files (aka configuration files) for neovim, zsh, tmux, and alacritty

## Setup

First You need to have git add GNU stow installed. 

Then clone the repository:

```sh
git clone https://github.com/Calbabreaker/dotfiles ~/.dotfiles
cd ~/.dotfiles
```

Now you can individually choose to use the dotfiles (specified by a folder) like so:

```sh
stow zsh
```

Or everything:

```sh
stow */
```

To remove a dotfile:

```sh
stow -D zsh
stow -D */ # all of them
```
