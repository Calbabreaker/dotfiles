#!/bin/sh

FOLDER=$(realpath `dirname $0`)
PLOVER_FOLDER=${XDG_CONFIG_HOME:-$HOME/.config}/plover

mkdir $PLOVER_FOLDER -p

confirm_exist() {
    [ -f $1 ] && \
        printf "$1 already exists. Want to override it? [y/n] " && read input

    [ -f $1 ] && [ ! $input = "y" ]
}

remote_dict() {
    FILENAME=$(echo $1 | rev | cut -d "/" -f 1 | rev)
    confirm_exist $PLOVER_FOLDER/$FILENAME || curl $1 > $PLOVER_FOLDER/$FILENAME
}

local_dict() {
    confirm_exist $PLOVER_FOLDER/$1 || ln -sf $FOLDER/$1 $PLOVER_FOLDER/$1
}

remote_dict "https://raw.githubusercontent.com/morinted/plover-inversion/master/inverted.json"

local_dict user.json
