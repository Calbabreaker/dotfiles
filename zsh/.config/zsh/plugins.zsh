PLUGIN_PATH=$ZSH_DATA_PATH/plugins

# add plugin
# $1 = github path
# $2 = file to source (default plugin_name.zsh)
# $3 = install function
function zsh_add_plugin {
    PLUGIN_NAME=$(echo $1 | cut -d "/" -f 2)

    if [ ! -d "$PLUGIN_PATH/$PLUGIN_NAME" ]; then
        git clone "https://github.com/$1.git" "$PLUGIN_PATH/$PLUGIN_NAME" --depth=1
        $3
    fi

    PLUGIN_FILE=$PLUGIN_PATH/$PLUGIN_NAME/${2:-$PLUGIN_NAME.zsh}
    [ -f $PLUGIN_FILE ] && source $PLUGIN_FILE
}

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

export FZF_ALT_C_COMMAND="command find -L . -mindepth 1 \\( -path '*/\\.*' -o -fstype 'sysfs' -o -fstype 'devfs' -o -fstype 'devtmpfs' -o -fstype 'proc' -o -name node_modules \\) -prune \
    -o -type d -print 2> /dev/null | cut -b3-"

export FZF_CTRL_T_COMMAND=$LIST_FILES_COMMAND

zsh_add_plugin "junegunn/fzf" "" fzf_install
source "$PLUGIN_PATH/fzf/shell/completion.zsh"
source "$PLUGIN_PATH/fzf/shell/key-bindings.zsh"
export PATH="$PATH:$PLUGIN_PATH/fzf/bin/"
