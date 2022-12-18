#!/usr/bin/env bash
# ┌───────────────────────── ─ ─   ─
# │ ~/.config/bash/bashrc.d/pkg.sh
# └───────────────────────── ─ ─   ─

PKG=$(command -v apt)

if [ $# = 0 ]; then
cat << EOF

$(tput bold)Gestionnaire de paquets $($PKG --version) $(tput sgr0)

  pkg install <pkgname1> <pkgname2>
  pkg remove <pkgname1> <pkgname2>
  pkg list-dependencies
           rev-dependencies
           available
           installed
           repository

EOF
exit 0
fi

case $1 in
  log)
    cat /var/log/apt/history.log
    ;;
  list-key|lr)
    apt-key list
    ;;
  list-repository|lr)
    grep --color=never ^ /etc/apt/sources.list /etc/apt/sources.list.d/*
    ;;
  list-available)
    apt-cache pkgnames
    ;;
  list-installed|ls)
    dpkg-query -l | grep '^ii' | awk '{print $2}'
    ;;
  list-all|ll)
    cache=$XDG_CACHE_HOME"pkg.cache"
    dpkg-query -l | grep '^ii' | awk '{print $2}' | sed -e 's/$/:apt:/' > $cache
    snap list | awk '{print $1}' | tail -n +2 | sed -e 's/$/:snap:/' >> $cache
    flatpak list | awk '{print $1}' | tail -n +2 | sed -e 's/$/:flat:/'  >> $cache
    cat $cache | sort
    ;;
  remove|rm|-d)
    sudo $PKG remove "${@:2}"
    ;;
  install|-I)
    if [ -z "${2}" ]; then
      apt list | sed 1d | cut -d/ -f1 | fzf --header=' ' --preview 'apt-cache show {1}' --ansi --color=bw --preview-window 'right,70%,border-left' --pointer='·' --info=hidden -m --padding 10% --ansi --color=bw --prompt='⟶   ' --bind change:first | xargs -ro sudo $PKG install
    else
      sudo $PKG "${@}"
    fi
    ;;
  list-dependencies)
    apt-cache depends "${@:2}"
    ;;
  list-rev-dependencies)
    apt-cache rdepends "${@:2}"
    ;;
  --version|-v|--help)
    $PKG "${@}"
    ;;
  list-snap)
    snap list | awk '{print $1}' | tail -n +2
    ;;
  info)
    if [ -z "${2}" ]; then
      apt list | sed 1d | cut -d/ -f1 | fzf --header=' ' --pointer='·' --info=hidden -m --padding 10% --ansi --color=bw --preview-window=up,60% --prompt='⟶   ' --bind change:first --preview-window 'right,70%' --preview 'apt-cache show {1}'
    else
      $PKG show $2
    fi
    ;;
  *)
    $PKG "${@}"
    ;;
esac

