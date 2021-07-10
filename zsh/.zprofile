#!/bin/zsh

# all environment variables go here
# note that you have to logout and login to refresh 

export PATH="$PATH:$HOME/.local/bin/"

# google sync api keys
export GOOGLE_DEFAULT_CLIENT_ID=77185425430.apps.googleusercontent.com
export GOOGLE_DEFAULT_CLIENT_SECRET=OTJgUOQcT7lO7GsGZq2G4IlT

# xdg dirs
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_CACHE_HOME="$HOME/.cache"

# put inside xdg dirs
export CARGO_HOME="$XDG_DATA_HOME/cargo"
export KDEHOME="$XDG_CONFIG_HOME/kde"
export ZDOTDIR="$XDG_CONFIG_HOME/zsh"
export _JAVA_OPTIONS=-Djava.util.prefs.userRoot="$XDG_CONFIG_HOME/java"

# history
export HISTSIZE=10000
export SAVEHIST=10000
export HISTFILE="$XDG_DATA_HOME/zsh_history"
