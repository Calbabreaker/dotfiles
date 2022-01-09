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
export PAGER='less -R --use-color -Dd+g$Dur$DPy' # colored man pages

export FILE_FIND_CMD="rg -g '!.git' --files --hidden"

function fzf-edit {
    $EDITOR $($FILE_FIND_CMD | fzf --preview 'bat --color=always --style=plain {}')
}

function fzf-open {
    xdg-open $($FILE_FIND_CMD | fzf)
}

zle -N fzf-edit
zle -N fzf-open

# keybinds
bindkey -s '^e' 'fzf-edit'
bindkey -s '^o' 'fzf-open'
bindkey -s '^f' '\ec tns^M'
