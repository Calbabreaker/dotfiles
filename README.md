# Dotfiles

Cool dot files for neovim, zsh, tmux, and alacritty.

## Setup

First You need to have git and GNU stow installed.
Then clone the repository:

```sh
git clone https://github.com/Calbabreaker/dotfiles ~/.dotfiles
cd ~/.dotfiles
```

Now you can individually choose to use a dotfile config (specified by a folder) like so:

```sh
stow zsh # zsh configuations
stow --no-folding scripts # --no-folding recommended
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

## Alacritty and zsh

![zsh-screenshot0](./.github/zsh-screenshot0.png)

