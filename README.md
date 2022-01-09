# Dotfiles

Cool dot files for Neovim, zsh, xmonad, and alacritty and other random programs.

## Setup

First you need to have git and GNU stow installed.
Then clone the repository:

```sh
git clone https://github.com/Calbabreaker/dotfiles ~/.dotfiles --depth=1
cd ~/.dotfiles
```

Now you can individually choose to use a dotfile config (specified by a folder) like so:

```sh
stow zsh # zsh configurations
stow nvim # Neovim configurations
stow scripts --no-folding # random scripts
```

To remove a dotfile:

```sh
stow -D zsh
stow -D scripts
```

## Neovim

NOTE: Requires Neovim >= 0.6 and probably only works on unix.

Need to quit Neovim and open back on first run.

![nvim-screenshot0](https://user-images.githubusercontent.com/57030377/146282089-c2401ec4-5c0e-4eb4-9066-d421d2c045b2.png)
![nvim-screenshot1](https://user-images.githubusercontent.com/57030377/146282094-8d57629c-88bf-4f84-a67a-344bc5ae3529.png)
![nvim-screenshot2](https://user-images.githubusercontent.com/57030377/147385270-cbd23f44-be6e-4790-ba15-57e821d89338.png)

By default no language servers or treesitter parsers are installed. Install a
language server (provides diagnostics and autocompletion) using
`:LspInstall language-name` (e.g. `:LspInstall c++`) and treesitter
parser using `:TSInstall language-name` (e.g. `:TSInstall c++`). Press
tab to see options.

[Prettierd](https://github.com/fsouza/prettierd) is needed to format
JavaScript, HTML, CSS, etc. files, (install with `npm install -g @fsouza/prettierd`).

Run `:W` to see all keybinds. Some basic keybinds are: `Ctrl-e` opens file
explorer, `Ctrl-t` opens terminal, `Alt-<` and `Alt->` goes between tabs, `Space-f`
finds and goes to files.

Might need to install `xsel` to make Neovim work with system clipboard.
[ripgrep]("https://github.com/BurntSushi/ripgrep") is also needed in order to use telescope.

## Xmonad

![xmonad-screenshot0](https://user-images.githubusercontent.com/57030377/146282118-4afee0c3-86a0-48a5-9d08-3fd76a7b0661.png)

Requirements (pacman):

```
sudo pacman -Sy xmonad xmonad-contrib xmobar dmenu xorg picom trayer volumeicon dunst \
    xdotool network-manager-applet xorg-xbacklight hsetroot xsecurelock xss-lock sx --needed
```

You also need to stow the scripts and xorg directory:

```
# from .dotfiles
stow scripts --no-folding
```

## Alacritty and zsh

![zsh-screenshot0](https://user-images.githubusercontent.com/57030377/146282133-c45581fc-f543-4279-9c7a-8b40148ab1ce.png)

NOTE: Need to install Source Code Pro Nerd Font (using `yay -S nerd-fonts-source-code-pro`)
in order for it to work. Also requires [ripgrep]("https://github.com/BurntSushi/ripgrep") for some keybinds.
