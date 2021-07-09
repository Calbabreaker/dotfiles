# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# disable ctrl+s freeze
stty -ixon
stty -tostop

setopt dotglob
setopt autocd
setopt EXTENDED_HISTORY
setopt HIST_EXPIRE_DUPS_FIRST
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_IGNORE_SPACE
setopt HIST_FIND_NO_DUPS
setopt HIST_SAVE_NO_DUPS
setopt HIST_BEEP

# load colours
autoload -U colors && colors

# tab completion thing
autoload -U compinit && compinit -u
zstyle ':completion:*' menu select
# auto complete with case insenstivity
zstyle ':completion:*' matcher-list '' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'
zmodload zsh/complist
compinit
_comp_options+=(globdots)		# Include hidden files.

source "$ZDOTDIR/functions.zsh"

zsh_add_file "aliases.zsh"
zsh_add_file "plugins.zsh"
zsh_add_file "prompt.zsh"
zsh_add_file "vi_mode.zsh"

zsh_add_plugin "zsh-users/zsh-syntax-highlighting"
zsh_add_plugin "zsh-users/zsh-autosuggestions"

