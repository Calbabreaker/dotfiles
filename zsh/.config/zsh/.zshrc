# if not running interactively, don't do anything
[[ $- != *i* ]] && return

# disable ctrl+s freeze
stty -ixon
stty -tostop

setopt dotglob
setopt autocd
setopt HIST_EXPIRE_DUPS_FIRST
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_IGNORE_SPACE
setopt HIST_FIND_NO_DUPS
setopt HIST_SAVE_NO_DUPS
setopt HIST_BEEP

# default programs 
export EDITOR="nvim"
export TERMINAL="alacritty"
export BROWSER="chromium"

# load colours and prompt
fpath+=$ZSH_DATA_PATH/prompts
autoload -U colors && colors
autoload -U promptinit; promptinit

source "$ZDOTDIR/aliases.zsh"
source "$ZDOTDIR/tab_comp_vi.zsh" # tab completion and vi mode
source "$ZDOTDIR/plugins.zsh"
