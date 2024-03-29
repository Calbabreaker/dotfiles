# Dotfiles

Cool dot files for Neovim, zsh, Qtile, and Alacritty and other random programs.

## Setup

First you need to have git and GNU stow installed.
Then clone the repository:

```bash
git clone https://github.com/Calbabreaker/dotfiles ~/.dotfiles --depth=1
cd ~/.dotfiles
```

Now you can individually choose to use a dotfile config (specified by a folder) like so:

```bash
stow zsh # zsh configurations
stow nvim # Neovim configurations
stow scripts # random scripts, make sure to add ~/.local/bin/personal to $PATH
```

To remove a dotfile:

```bash
stow -D zsh
stow -D scripts
```

NOTE: Most dotfile configs (Qtile, Neovim, zsh) requires Source Code Pro Nerd
Font (install using `sudo pacman -S ttf-sourcecodepro-nerd`) in order for them to
work properly.

## Neovim

NOTE: Requires the lastest version of Neovim and probably only works on linux. Also need to quit Neovim and open back on first run.

![nvim-screenshot0](https://user-images.githubusercontent.com/57030377/163508783-062771cd-8e54-4645-8687-f6f6cf1135c8.png)
![nvim-screenshot1](https://user-images.githubusercontent.com/57030377/163508796-a9a8bfe6-b3a1-482d-8b82-11fd45be94e8.png)
![nvim-screenshot2](https://user-images.githubusercontent.com/57030377/147385270-cbd23f44-be6e-4790-ba15-57e821d89338.png)

By default no language servers or treesitter parsers are installed. Install
language servers (provides diagnostics and autocompletion) using `:LspInstall language-name`
(eg. `:LspInstall c++`) and treesitter parser using `:TSInstall language-name` (eg. `:TSInstall c++`).
Also install formatters and linters with `:MasonInstall name` (eg. `:MasonInstall prettierd`).
Press tab to see options.

Run `:W` to see all keybinds. Some basic keybinds are: `Ctrl-e` opens file
explorer, `Ctrl-t` opens terminal, `Alt-<` and `Alt->` goes between tabs, `Space-o`
opens file picker.

Install `xsel` to make Neovim work with system clipboard.
[ripgrep](https://github.com/BurntSushi/ripgrep) is also needed in order to use telescope.

## Qtile

![qtile-screenshot](https://user-images.githubusercontent.com/57030377/149144917-68214f99-484a-4cc0-912c-6eb01fc7ff9b.png)

Requirements (pacman):

```bash
sudo pacman -S --needed xorg sx qtile python-dbus-next python-psutil picom dunst xsecurelock xss-lock \
    hsetroot noto-fonts-emoji ttf-liberation volumeicon fcitx5 fcitx5-gtk fcitx5-qt fcitx5-configtool \
    network-manager-applet xorg-xbacklight dmenu xdg-utils lxappearance-gtk3 alacritty pcmanfm-gtk3
```

Now run `sx qtile start` from a tty to start qtile or add this to your shell login script
(usually `~/.bash_profile` or `~/.zprofile`) to automatically start it on login:

```bash
if [ "$(tty)" = "/dev/tty1" ]; then
    pidof Xorg || sx qtile start
fi
```

To set a wallpaper copy an image file to `~/.local/share/wallpaper.*` or use the
`setwallpaper` script in the scripts directory which will also allow you to blur the
image or set as a colour.

## Kitty and zsh

![zsh-screenshot0](https://user-images.githubusercontent.com/57030377/146282133-c45581fc-f543-4279-9c7a-8b40148ab1ce.png)

Requires [ripgrep](https://github.com/BurntSushi/ripgrep) for finding files.
