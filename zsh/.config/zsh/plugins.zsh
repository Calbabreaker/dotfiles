PLUGIN_PATH=$ZSH_DATA_PATH/plugins

# add plugin
# $1 = github path @ to specify commit
# $2 = file to source (default plugin_name.zsh)
# $3 = install function
function zsh_add_plugin {
    local GITHUB_PATH=$(cut -d "@" -f 1 <<< $1)
    local PLUGIN_NAME=$(cut -d "/" -f 2 <<< $GITHUB_PATH)
    local GIT_REF=$(cut -d "@" -f 2 <<< $1)
    [[ $GIT_REF == $1 ]] && unset GIT_REF

    if [ ! -d "$PLUGIN_PATH/$PLUGIN_NAME" ]; then
        git init "$PLUGIN_PATH/$PLUGIN_NAME"
        pushd "$PLUGIN_PATH/$PLUGIN_NAME"
        git remote add origin https://github.com/$GITHUB_PATH
        git fetch --depth 1 origin $GIT_REF
        git checkout FETCH_HEAD
        popd
        $3
    fi

    PLUGIN_FILE=$PLUGIN_PATH/$PLUGIN_NAME/${2:-$PLUGIN_NAME.zsh}
    [ -f $PLUGIN_FILE ] && source $PLUGIN_FILE
}

# zsh syntax highlighting
zsh_add_plugin "zsh-users/zsh-syntax-highlighting" 

# zsh suggestions
zsh_add_plugin "zsh-users/zsh-autosuggestions"
bindkey '^ ' autosuggest-accept

#
# Spaceship prompt - very nice prompt
# 
SPACESHIP_PROMPT_ASYNC=false
SPACESHIP_CHAR_SYMBOL=»
SPACESHIP_CHAR_SUFFIX=" "

SPACESHIP_PROMPT_ORDER=(
    dir           # Current directory section
    git           # Git section (git_branch + git_status)
    exec_time     # Execution time
    char          # Prompt character
)

# https://github.com/spaceship-prompt/spaceship-prompt/issues/1178 set specific version that works
zsh_add_plugin "spaceship-prompt/spaceship-prompt" "spaceship.zsh"

#
# Fzf for fuzzy finding productivity
# 
function fzf_install() {
    mkdir ~/.local/bin/
    $PLUGIN_PATH/fzf/install --bin 
    ln -sf $PLUGIN_PATH/fzf/bin/fzf ~/.local/bin/fzf
}

export LIST_FILES_COMMAND="rg -g '!.git' --files --hidden"
export FZF_ALT_C_COMMAND="rg -g '!.git' --files --null | xargs -0 dirname | sort -u"
export FZF_CTRL_T_COMMAND=$LIST_FILES_COMMAND

zsh_add_plugin "junegunn/fzf" "" fzf_install
source "$PLUGIN_PATH/fzf/shell/key-bindings.zsh"

function fzf-edit {
    local file=$(eval $LIST_FILES_COMMAND | fzf --preview 'bat --color=always --style=plain {}')
    if [ -z "$file" ]; then
        return 0
    fi
    BUFFER="nvim '$file'"
    zle accept-line
}

function fzf-open {
    local file=$(eval $LIST_FILES_COMMAND | fzf)
    if [ -z "$file" ]; then
        return 0
    fi
    BUFFER="xdg-open '$file'"
    zle accept-line
}

zle -N fzf-edit
zle -N fzf-open

# keybinds
bindkey '^e' 'fzf-edit'
bindkey '^o' 'fzf-open'
