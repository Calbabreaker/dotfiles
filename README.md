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

By default no language servers treesitter parsers (basically really good syntax
highlighting) are installed. You can install a language server using
`:LspInstall server_name` (eg. `:LspInstall tsserver` for JavaScript and
Typescript) and a treesitter parser with `:TSInstall language-name` (eg.
`:TSInstall javascript`).

You will need to have prettier installed (using `npm install -g prettier` or
`yarn global add prettier`) to format JavaScript, HTML, CSS, etc. files.

You might need to install `xsel` to make it work with system clipboard.

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

