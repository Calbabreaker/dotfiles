# colour support
alias ls='ls --color=auto'
alias dir='dir --color=auto'
alias vdir='vdir --color=auto'
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

# useful ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'
alias l="ls -G"

# confirm before doing
alias rm="rm -Iv"
alias cp="cp -rv"
alias mv="mv -v"

# misc
alias c="clear"
alias cb="xclip -selection c" # pipe to to copy to clipboard
alias yarn='yarn --use-yarnrc "$XDG_CONFIG_HOME/yarn/config"'
