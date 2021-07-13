# source files if they exist
function zsh_add_file() {
    [ -f "$1" ] && source "$1"
}

export PLUGIN_PATH=$ZSH_DATA_PATH/plugins

# add plugin
# $1 = github path
# $2 = file to source (default plugin_name.zsh)
# $3 = install function
function zsh_add_plugin() {
    PLUGIN_NAME=$(echo $1 | cut -d "/" -f 2)
    FILE=${2:-"$PLUGIN_NAME.zsh"}

    if [ ! -d "$PLUGIN_PATH/$PLUGIN_NAME" ]; then
        git clone "https://github.com/$1.git" "$PLUGIN_PATH/$PLUGIN_NAME" --depth=1
        $3
    fi

    zsh_add_file "$PLUGIN_PATH/$PLUGIN_NAME/$FILE" 
}

function zsh_update_plugins() {
    for dir in $PLUGIN_PATH/*/; do
        [ -d $dir/.git ] && git -C $dir pull 
    done
}
