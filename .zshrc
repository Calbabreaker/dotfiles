ZSH_THEME="af-magic"
_comp_options+=(globdots)

# enable command auto-correction.
ENABLE_CORRECTION="true"

# display red dots whilst waiting for completion.
COMPLETION_WAITING_DOTS="true"

# plugins
plugins=(git vi-mode)

# zsh source
export ZSH="/home/calbabreaker/.oh-my-zsh"
source $ZSH/oh-my-zsh.sh

# zsh_history
HISTSIZE=10000
SAVEHIST=10000
HISTFILE=~/.zsh_history

# vim keybinds in tab complete menu
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'j' vi-down-line-or-history
bindkey -v '^?' backward-delete-char

# preferred editor for local and remote sessions
export EDITOR='vim'

#
# ------------------- setup of software ------------------------
#
pathadd() {
    if [[ ":$PATH:" != *":$1:"* ]]; then
        PATH="${PATH:+"$PATH:"}$1"
    fi
}

pathadd "$HOME/.deno/bin"
pathadd "/usr/lib/ccache"
pathadd "$HOME/.local/bin"

# loads nvm
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

#
# ------------------- aliases -------------------
#

alias cb="xclip -selection c" # pipe to to copy to clipboard
alias c="clear"
alias rm="rm -Iv"
alias cp="cp -rv"
alias mv="mv -v"

alias aptmanage='sudo apt update && sudo apt upgrade && sudo apt autoremove && sudo apt clean'

autoclick() {
    xdotool click --repeat $1 --delay 18 1
}

