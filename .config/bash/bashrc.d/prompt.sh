#!/usr/bin/env bash
# ┌───────────────────────── ─ ─   ─
# │ ~/.config/bash/bashrc.d/prompt.sh
# └───────────────────────── ─ ─   ─
# Bash prompt for the readline


# ····· options
SHOW_GIT_IN_PS1=1


# \1 and \2 are escape sequence for "set bind ..."
_c() { echo -e "\033[38;5;${1}m"; }


# ····· get time of execution of the last command
function timer_start { timer=${timer:-$SECONDS} ; }
function timer_stop { timer_show=$(($SECONDS - $timer)) && unset timer ; }
seconds2days() {
  # convert integer seconds to Ddays,HH:MM:SS
  #   https://stackoverflow.com/a/2732282
  #
  if [[ $1 -gt 86400 ]] ; then printf "%.fd " $(( ( ($1/60)/60)/24 )) ; fi
  if [[ $1 -gt 3600 ]] ; then printf "%.fh " $(( ( ($1/60)/60 )%24 )) ; fi
  if [[ $1 -gt 60 ]] ; then printf "%.fm " $(( ($1/60)%60 )) ; fi
  printf "%.fs" $(($1%60))
}


# ····· concat infos for git status in prompt
git_add_to_st() { if [ "$1" -ne 0 ] ; then git_st+=" $1$2" ; fi ; }

prompt_command() {

  local status="$?"

  local is_git_repo="$(git rev-parse --is-inside-work-tree 2> /dev/null)"
  local is_root="$([[ "${EUID}" == 0 ]] && echo root)"
  local is_venv="$([[ "$VIRTUAL_ENV" ]] && echo venv)"

  local dircolor=`_c 239`
  local envcolor=`_c 77` # 77 165
  local gitcolor=`_c 138`
  local errcolor=`_c 197`
  local timcolor=`_c 208`

  bind "set show-mode-in-prompt on"


  # --------------------------- current directory or "~" if home
  # 🖿  🗀   ꗃ ⧗ ⛨
  local enddir=""
  local dir_ico="/"
  [[ -w `pwd` ]] && enddir+="" || enddir+=""
  enddir+=$(pwd | sed "s/.*\///g" | sed "s/$USER/\~/g" )
  if [ $PWD == "/" ] ; then
    [[ -n "$is_root" ]] && enddir+="~"
  fi
  enddir+=${dir_ico}


  # --------------------------- icon
  if ! [ -n "$is_root" ] ; then ico=${ico_lambda} ; else ico="root" ; fi
  ico_git="▲" # "მ"


  # --------------------------- git
  local total_local=0
  if [ -n "$is_git_repo" -a "${SHOW_GIT_IN_PS1}" == "1" ]; then

    local git_st git_branch
    local untracked modified stagged deleted

    ico="${ico_git}"

    # get the current branch name, if stashed change surround !
    git_branch=$(git rev-parse --abbrev-ref HEAD 2> /dev/null)
    if [ "$(git rev-list --walk-reflogs --count refs/stash 2> /dev/null)" != "" ] ; then
      git_branch="[\1\033[3m\2$git_branch\1\033[23m\2]"
    else
      git_branch="[$git_branch]"
    fi

    untracked=$(git status --porcelain 2>/dev/null | \grep -c '^??')
    modified=$(git ls-files --modified `git rev-parse --show-cdup` | wc -l)
    stagged=$(git diff --staged --name-status | wc -l)
    deleted=$(git status --porcelain | grep '^ D .*$' | wc -l)

    stash=$(git stash list 2> /dev/null | wc -l)

    remote=`git rev-parse --abbrev-ref @{u} 2> /dev/null`
    if [ -z "$remote" ]; then
      head=
      leftahead=0
      rightahead=0
    else
      head=`git rev-parse --abbrev-ref HEAD`
      leftahead=`git rev-list --count @{u}..HEAD`
      rightahead=`git rev-list --count HEAD..@{u}`
    fi

    # prompt indicator
    git_add_to_st $stash     "!"
    git_add_to_st $untracked "?"
    git_add_to_st $deleted   "-"
    git_add_to_st $modified  "~"
    git_add_to_st $stagged   "⚐"
    git_add_to_st $leftahead "↥"
    git_add_to_st $rightahead "⇣"

    # if nothing to show, show nothing about git
    total_local=$(($untracked + $modified + $stagged + $deleted))
    if [ $total_local -ne 0 ] ; then
      enddir=
    else
      git_branch=
    fi

  fi


  # --------------------------- classical PS1 if home
  if [ "${PWD}" == "${HOME}" ] && [ $total_local -eq 0 ] ; then
  # if [ $total_local -eq 0 ] ; then
    ico="[$USER@$HOSTNAME]"
  fi

  # --------------------------- jobs
  j="$(jobs | wc -l)"
  if [ "$j" -gt  "0" ]; then ico="\1\033[4m\2$ico\1\033[24m\2" ; fi

  # --------------------------- exec time
  timer_stop
  if [[ $timer_show -gt 3 ]] ; then
    timer_show=" $(seconds2days $timer_show)"
  else
    timer_show=
  fi


  # --------------------------- PS1
  # ⟵-- ┄─🡲 🡢 ─⟶
  begin="    "
  arrow=" "
  p1="$begin$ico $enddir$git_branch$git_st$timer_show$arrow"
  p256="$begin$ico\1$dircolor\2 $enddir$git_branch\1$gitcolor\2$git_st\1$timcolor\2$timer_show$arrow"
  bind "set vi-cmd-mode-string \1\033[00m\2\1\033[2m\2$p1\1\033[00m\2\1\033[1m\2"
  export PS1="\n"


  # --------------------------- python venv (color)
  if [ -n "$is_venv" ]; then
    export PYVENV="(${VIRTUAL_ENV##*/})"
    bind "set vi-ins-mode-string \1\033\2\1[00m$envcolor\2$p256\1\033[00m\2"
  else
    PYTHONVER="$(ls /usr/bin | grep '^python3\.*$')"
    export PYVENV=
    bind "set vi-ins-mode-string \1\033[00m\2\1\033[38;5;32m\2$p256\1\033[00m\2"
  fi


  # --------------------------- error (color)
  if [ $status != 0 ]; then
    # prompt "ins" "$p256" "\033[38;5;197m" "$reset"
    bind "set vi-ins-mode-string \1\033[00m\2\1\033[38;5;197m\2$p256\1\033[00m\2"
  fi


  # --------------------------- save last PWD
  if ! [ -n "$is_root" ] ; then
    mkdir -p $XDG_CACHE_HOME/bash
    pwd > $XDG_CACHE_HOME/bash/lastdirectory
  fi

  unset ico_git j p
}

trap 'timer_start' DEBUG

export PROMPT_COMMAND=prompt_command



# ····· sudo prompt !
# export SUDO_PROMPT='    [%p@%h]  '
