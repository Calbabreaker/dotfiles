#!/bin/sh

if [ "$(tty)" = "/dev/tty1" ]; then
    pidof Xorg || sx qtile start
fi
