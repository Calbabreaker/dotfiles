#!/bin/zsh

# most environment variables go here
# note that you have to logout and login to refresh 

export MOZ_USE_XINPUT2=1

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
export RUSTUP_HOME=$XDG_DATA_HOME/rustup
export WGETRC=$XDG_CONFIG_HOME/wgetrc
export WINEPREFIX=$XDG_DATA_HOME/wineprefixes/default
export XINITRC=$XDG_CONFIG_HOME/X11/xinitrc
export ZDOTDIR=$XDG_CONFIG_HOME/zsh
export ZSH_DATA_PATH=$XDG_DATA_HOME/zsh
export _JAVA_OPTIONS=-Djava.util.prefs.userRoot=$XDG_CONFIG_HOME/java
export GOPATH=$XDG_DATA_HOME/go
export GOMODCACHE=$XDG_CACHE_HOME/go/mod

# history
export HISTSIZE=10000
export SAVEHIST=10000
export HISTFILE=$ZSH_DATA_PATH/history.txt

export PATH=$HOME/.local/bin:$HOME/.local/bin/personal

export GLFW_IM_MODULE=ibus
export GTK_IM_MODULE=fcitx5
export QT_IM_MODULE=fcitx5
export SDL_IM_MODULE=fcitx
export XMODIFIERS=@im=fcitx5
