# Dotfiles

Cool dot files for Neovim, zsh, Qtile, and Alacritty and other random programs.

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
stow scripts # random scripts, make sure to add ~/.local/bin/personal to $PATH
```

To remove a dotfile:

```sh
stow -D zsh
stow -D scripts
```

NOTE: Most dotfile configs (Qtile, Neovim, zsh) requires Source Code Pro Nerd
Font (install using `yay -S nerd-fonts-source-code-pro`) in order for them to
work properly.

## Neovim

NOTE: Requires Neovim >= 0.6 and probably only works on unix.

Need to quit Neovim and open back on first run.

![nvim-screenshot0](https://user-images.githubusercontent.com/57030377/163508783-062771cd-8e54-4645-8687-f6f6cf1135c8.png)
![nvim-screenshot1](https://user-images.githubusercontent.com/57030377/163508796-a9a8bfe6-b3a1-482d-8b82-11fd45be94e8.png)
![nvim-screenshot2](https://user-images.githubusercontent.com/57030377/147385270-cbd23f44-be6e-4790-ba15-57e821d89338.png)

By default no language servers or treesitter parsers are installed. Install a
language server (provides diagnostics and autocompletion) using
`:LspInstall language-name` (e.g. `:LspInstall c++`) and treesitter
parser using `:TSInstall language-name` (e.g. `:TSInstall c++`). Press
tab to see options.

[Prettierd](https://github.com/fsouza/prettierd) is needed to format
JavaScript, HTML, CSS, etc. files, (install with `npm install -g @fsouza/prettierd`).

Run `:W` to see all keybinds. Some basic keybinds are: `Ctrl-e` opens file
explorer, `Ctrl-t` opens terminal, `Alt-<` and `Alt->` goes between tabs, `Space-o`
opens file picker.

Might need to install `xsel` to make Neovim work with system clipboard.
[ripgrep](https://github.com/BurntSushi/ripgrep) is also needed in order to use telescope.

## Qtile

![qtile-screenshot](https://user-images.githubusercontent.com/57030377/149144917-68214f99-484a-4cc0-912c-6eb01fc7ff9b.png)

Requirements (pacman):

```sh
sudo pacman -Sy --needed xorg sx qtile python-dbus-next python-psutil picom dunst xsecurelock xss-lock \
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

To set a wallpaper copy an image file to `~/.local/share/wallpaper.png` or use the
`setwallpaper` script in the scripts directory which will allow you to blur the
image or set as a colour.

For updates widget to work, add this to your `/etc/sudoers` (edit using visudo):

```
%wheel ALL=(root) NOPASSWD: /usr/bin/pacman -Syu, /usr/bin/pacman -Sy
```

## Alacritty and zsh

![zsh-screenshot0](https://user-images.githubusercontent.com/57030377/146282133-c45581fc-f543-4279-9c7a-8b40148ab1ce.png)

NOTE: Need to install Source Code Pro Nerd Font (using `yay -S nerd-fonts-source-code-pro`)
in order for it to work. Also requires [ripgrep](https://github.com/BurntSushi/ripgrep) for some keybinds.
