#!/bin/sh

if [ "$(tty)" = "/dev/tty1" ]; then
    [ -f "$XDG_DATA_HOME/REMIND_ME" ] && notify-send "Reminders" "$(cat $XDG_DATA_HOME/REMIND_ME)" &
    command -v qtile > /dev/null && pidof Xorg || sx qtile start
fi
