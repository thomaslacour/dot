#!/usr/bin/env bash
# ┌───────────────────────── ─ ─   ─
# │ ~/.config/bash/bashrc.d/fzf.sh
# └───────────────────────── ─ ─   ─

git () {
  # to be aware of git forge aliases
  if [ "$PWD" == "$HOME" ] ; then
    GIT="/usr/bin/git --git-dir=$HOME/.dot --work-tree=$HOME"
  else
    GIT="/usr/bin/git"
  fi

  case $1 in
    fzf)
      $GIT status --short | fzf --color='dark,fg:-1,bg:-1,pointer:-1,hl:-1,gutter:-1,bg+:-1:reverse,prompt:-1,border:-1' --bind change:first --preview-window 'right,70%' --preview "${GIT} -c color.ui=always diff {2} | sed 's/\(^+.*\)/\x1b[31m\1\x1b[0m/'"
      ;;
    branch)
      $GIT rev-parse --abbrev-ref HEAD 2> /dev/null
      ;;
    *)
      $GIT "${@}"
      ;;
  esac
}

