# Dotfiles

Cool dot files for neovim, zsh, xmonad, and alacritty and other random stuff

## Setup

First You need to have git and GNU stow installed.
Then clone the repository:

```sh
git clone https://github.com/Calbabreaker/dotfiles ~/.dotfiles
cd ~/.dotfiles
```

Now you can individually choose to use a dotfile config (specified by a folder) like so:

```sh
stow zsh # zsh configurations
stow nvim # NeoVim configurations
```

NOTE: The plover directory **shouldn't** be ran with stow; run `plover/setup.sh` instead.

To remove a dotfile:

```sh
stow -D zsh
stow -D scripts
```

## NeoVim

Note: Requires version 0.5

To set up NeoVim (after stowed) run `:PackerSync` in NeoVim.

![nvim-screenshot0](./.github/nvim-screenshot0.png)
![nvim-screenshot1](./.github/nvim-screenshot1.png)

By default no language servers or treesitter parsers are installed.
Install a treesitter parser using `:TSInstall language-name` (e.g. `:TSInstall javascript`)
and language server using `:LspInstall language-server` (e.g. `:LspInstall
tsserver`). Press tab to see options.

Prettier will be needed to format JavaScript, HTML, CSS, etc. files, and
clang-format will be needed to format C++, C files.

Run `:W` to see keybinds (there are a lot).

Might need to install `xsel` to make NeoVim work with system clipboard.

## Xmonad

Requirements (pacman):

```
sudo pacman -Sy xmonad xmonad-contrib xmobar dmenu xorg picom nitrogen trayer volumeicon dunst \
    xdotool network-manager-applet lightdm lightdm-gtk-greeter light-locker xorg-xbacklight --needed
```

You also need to stow the scripts directory:

```
# from .dotfiles
stow scripts
```

![xmonad-screenshot0](./.github/xmonad-screenshot0.png)

## Alacritty and zsh

![zsh-screenshot0](./.github/zsh-screenshot0.png)

Note: install Source Code Pro Nerd Font (using `yay -S nerd-fonts-source-code-pro`)
