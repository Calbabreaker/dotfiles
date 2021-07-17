# Dotfiles

Cool dot files for neovim, zsh, tmux, and alacritty.

## Setup

First You need to have git add GNU stow installed.

Then clone the repository:

```sh
git clone https://github.com/Calbabreaker/dotfiles ~/.dotfiles
cd ~/.dotfiles
```

Now you can individually choose to use a dotfile (specified by a folder) like so:

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

## NeoVim

Note: Requires version 0.5

To set up NeoVim (after stowed) run `:PackerSync` in NeoVim.

![nvim-screenshot0](./.github/nvim-screenshot0.png)
![nvim-screenshot1](./.github/nvim-screenshot1.png)

## Alacritty and zsh

![zsh-screenshot0](./.github/zsh-screenshot0.png)
