#!/bin/sh

FOLDER=$(realpath `dirname $0`)
PLOVER_FOLDER=${XDG_CONFIG_HOME:-$HOME/.config}/plover

mkdir $PLOVER_FOLDER -p

remote_dict() {
    FILENAME=$(echo $1 | rev | cut -d "/" -f 1 | rev)
    curl -O $1 -o $XDG_CONFIG_HOME/$FILENAME
}

local_dict() {
    [ -f $PLOVER_FOLDER/$1 ] && \
        printf "$PLOVER_FOLDER/$1 already exists. Want to override it? [y/n] " && read input

    [ -f $PLOVER_FOLDER/$1 ] && [ ! $input = "y" ] || \
        ln -sf $FOLDER/$1 $PLOVER_FOLDER/$1
}

remote_dict "https://raw.githubusercontent.com/morinted/plover-inversion/master/inverted.json"

local_dict user.json
