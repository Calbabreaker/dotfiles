# source files if they exist
function zsh_add_file() {
    [ -f "$ZDOTDIR/$1" ] && source "$ZDOTDIR/$1"
}

# add plugin
# $1 = github path
# $2 = file to run (default plugin_name.zsh)
# $3 = install function
function zsh_add_plugin() {
    PLUGIN_NAME=$(echo $1 | cut -d "/" -f 2)
    FILE=${2:-"$PLUGIN_NAME.zsh"}

    if [ ! -d "$ZDOTDIR/plugins/$PLUGIN_NAME" ]; then
        git clone "https://github.com/$1.git" "$ZDOTDIR/plugins/$PLUGIN_NAME" --depth=1
        $3
    fi

    zsh_add_file "plugins/$PLUGIN_NAME/$FILE" 
}

function zsh_update_plugins() {
    for dir in $ZDOTDIR/plugins/*/; do
        [ -d $dir/.git ] && git -C $dir pull 
    done
}
