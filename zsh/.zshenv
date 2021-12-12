#!/bin/zsh

# most environment variables go here
# note that you have to logout and login to refresh 

# google sync api keys
export GOOGLE_DEFAULT_CLIENT_ID=77185425430.apps.googleusercontent.com
export GOOGLE_DEFAULT_CLIENT_SECRET=OTJgUOQcT7lO7GsGZq2G4IlT

# xdg dirs
export XDG_CONFIG_HOME=$HOME/.config
export XDG_DATA_HOME=$HOME/.local/share
export XDG_CACHE_HOME=$HOME/.cache

# put inside xdg dirs
export CALCHISTFILE=$XDG_CACHE_HOME/calc_history
export CARGO_HOME=$XDG_DATA_HOME/cargo
export DOCKER_CONFIG=$XDG_CONFIG_HOME/docker
export GNUPGHOME=$XDG_DATA_HOME/gnupg
export GTK2_RC_FILES=$XDG_CONFIG_HOME/gtk-2.0/gtkrc
export GTK_RC_FILES=$XDG_CONFIG_HOME/gtk-1.0/gtkrc
export KDEHOME=$XDG_CONFIG_HOME/kde
export NODE_REPL_HISTORY=$XDG_DATA_HOME/node_repl_history
export NPM_CONFIG_USERCONFIG=$XDG_CONFIG_HOME/npm/npmrc
export PYTHONHISTORY=$XDG_DATA_HOME/python_history
export WGETRC=$XDG_CONFIG_HOME/wgetrc
export WINEPREFIX=$XDG_DATA_HOME/wineprefixes/default
export ZDOTDIR=$XDG_CONFIG_HOME/zsh
export ZSH_DATA_PATH=$XDG_DATA_HOME/zsh
export _JAVA_OPTIONS=-Djava.util.prefs.userRoot=$XDG_CONFIG_HOME/java
export XINITRC=$XDG_CONFIG_HOME/X11/xinitrc

# history
export HISTSIZE=10000
export SAVEHIST=10000
export HISTFILE=$ZSH_DATA_PATH/history.txt

export PATH=$HOME/.local/bin:$XDG_DATA_HOME/npm/bin:$PATH

# xsecurelock
export XSECURELOCK_PASSWORD_PROMPT=asterisks
export XSECURELOCK_NO_COMPOSITE=1