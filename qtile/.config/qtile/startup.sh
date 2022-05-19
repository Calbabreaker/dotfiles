#!/bin/bash

picom -b --experimental-backend &  # compisitor
nm-applet &  # network manager
dunst & # notification server
(volumeicon; volumeicon) & 
fcitx & # keyboard layout manager

DATA_HOME=${XDG_DATA_HOME:-$HOME/.local/share}
sh $DATA_HOME/wallpaper-command.sh || hsetroot -cover $DATA_HOME/wallpaper.* || notify-send "No wallpaper found!"

# auto screen locker
export XSECURELOCK_PASSWORD_PROMPT=asterisks
export XSECURELOCK_NO_COMPOSITE=1
xss-lock -n /usr/lib/xsecurelock/dimmer -l -- xsecurelock &
