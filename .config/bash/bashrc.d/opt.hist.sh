#!/usr/bin/env bash
# ┌───────────────────────── ─ ─   ─
# │ ~/.config/bash/bashrc.d/hist.sh
# └───────────────────────── ─ ─   ─

# path to store bash history
export HISTFILE=$XDG_DATA_HOME"/bash/history"

# create file and parent folder if needed
mkdir -p $XDG_DATA_HOME"/bash/" && touch $HISTFILE

HISTIGNORE="&:[ ]*:exit:ls:bg:fg:history:cd_*"

HISTCONTROL="erasedups:ignoreboth" # avoid duplicate entry
HISTSIZE= # ························ size of history file
HISTFILESIZE=1000 # ················ no history
shopt -s histappend # ·············· append history to file
shopt -s cmdhist # ················· easy multiline history
shopt -s checkwinsize # ············ get windows size
