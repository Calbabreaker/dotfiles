#!/bin/sh

if [ "$(tty)" = "/dev/tty1" ]; then
    pidof Xorg || sx sh ${XINITRC-$HOME/.Xinitrc}
fi
