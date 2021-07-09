# Dotfiles

Personal dot files (aka configuration files) for neovim, git, zsh and alacritty.

## Setup

First You need to have git add GNU stow installed. 

Then clone the repository:

```sh
git clone https://github.com/Calbabreaker/dotfiles ~/.dotfiles
cd ~/.dotfiles
```

Now you can individually choose the dotfiles (specified by a folder) like so:

```sh
stow zsh
```

Or everything:

```sh
stow */
```
