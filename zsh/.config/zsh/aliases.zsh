# colour support
alias ls="ls --color=auto"
alias dir="dir --color=auto"
alias vdir="vdir --color=auto"
alias grep="grep --color=auto"
alias fgrep="fgrep --color=auto"
alias egrep="egrep --color=auto"

# useful ls aliases
command -v exa > /dev/null && alias ls="exa --icons --group-directories-first" # exa is ls replacement
alias ll="ls -halF"
alias la="ls -a"
alias l="ls"
alias lsr="ls --no-icons"

# confirm before doing
alias rm="rm -Iv"
alias cp="cp -rv"
alias mv="mv -v"

# misc
alias c="clear"
alias cb="xclip -selection c" # pipe to to copy to clipboard
alias szsh="source $ZDOTDIR/.zshrc"
alias wget="wget --hsts-file='$XDG_CACHE_HOME/wget-hsts'"
alias wininit="echo 'i am using linux idiot'"
alias mvim="nvim -u $XDG_CONFIG_HOME/nvim/minimal.lua"
alias v="nvim"
alias lg="lazygit"
alias o="xdg-open"
export PAGER='less -R --use-color -Dd+g$Dur$DPy' # coloured man pages
bindkey -s '^f' 'ranger^M'

alias idump='objdump  --disassembler-color=extended -M intel -D'

# Bind history forward/back
bindkey '^k' up-line-or-history
bindkey '^j' down-line-or-history
