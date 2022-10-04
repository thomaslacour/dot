#!/usr/bin/env bash
# ┌───────────────────────── ─ ─   ─
# │ ~/.config/bash/bashrc.d/autovenv.sh
# └───────────────────────── ─ ─   ─

shopt -s dotglob

function cd () {
  builtin cd "$@"
  if [[ -z "$VIRTUAL_ENV" ]] ; then
    for d in */ .*/ ; do
      if compgen -G "$d"pyvenv.cfg > /dev/null; then
        source "$d"/bin/activate
        return
      fi
    done
  else
    parentdir="$(dirname "$VIRTUAL_ENV")"
    if [[ "$PWD"/ != "$parentdir"/* ]] ; then
      deactivate
    fi
  fi
}

