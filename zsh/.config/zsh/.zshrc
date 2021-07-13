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

# tab completion thing
autoload -U compinit && compinit -u
zstyle ':completion:*' menu select
# auto complete with case insenstivity
zstyle ':completion:*' matcher-list '' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'
zmodload zsh/complist
compinit
_comp_options+=(globdots)		# Include hidden files.

source "$ZDOTDIR/functions.zsh"
source "$ZDOTDIR/aliases.zsh"
source "$ZDOTDIR/vi_mode.zsh"

zsh_add_plugin "zsh-users/zsh-syntax-highlighting" 

zsh_add_plugin "zsh-users/zsh-autosuggestions"
bindkey '^ ' autosuggest-accept

SPACESHIP_PROMPT_ADD_NEWLINE=false
SPACESHIP_PROMPT_SEPARATE_LINE=false
SPACESHIP_CHAR_SYMBOL=»
SPACESHIP_CHAR_SUFFIX=" "

SPACESHIP_PROMPT_ORDER=(
  dir           # Current directory section
  git           # Git section (git_branch + git_status)
  exec_time     # Execution time
  char          # Prompt character
)

function spaceship_install() {
    mkdir -p $ZSH_DATA_PATH/prompts
    ln -sf "$PLUGIN_PATH/spaceship-prompt/spaceship.zsh" "$ZSH_DATA_PATH/prompts/prompt_spaceship_setup"
}

zsh_add_plugin "spaceship-prompt/spaceship-prompt" "" spaceship_install
prompt spaceship

function fzf_install() {
    $PLUGIN_PATH/fzf/install --bin 
}

zsh_add_plugin "junegunn/fzf" "" fzf_install
source "$PLUGIN_PATH/fzf/shell/completion.zsh"
source "$PLUGIN_PATH/fzf/shell/key-bindings.zsh"
export PATH="$PATH:$PLUGIN_PATH/fzf/bin/"
