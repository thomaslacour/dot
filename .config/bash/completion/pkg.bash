#/usr/bin/env bash

_pkg() {

  local cur command commands options packages files

  COMPREPLY=()
  cur=${COMP_WORDS[COMP_CWORD]}

  commands="install \
            search \
            upgrade \
            info \
            log \
            ls \
            list-available \
            list-key \
            list-repository \
            list-installed \
            list-dependencies \
            list-rev-dependencies \
            remove"

  options="--help"
  packages=""
  files=""


  if [[ $COMP_CWORD -eq 1 ]] ; then
    if [[ "$cur" == -* ]]; then
      COMPREPLY=($(compgen -W "--version --help" -- $cur))
    else
      COMPREPLY=($(compgen -W "$commands --version --help" -- $cur))
    fi
    return 0;
  else
     command=${COMP_WORDS[1]}

     if [[ "$cur" == -* ]]; then
       COMPREPLY=($(compgen -W "$options" -- $cur))
       return 0;
     else
       case $command in
         install|-I)
           # all packages
           # packages=`apt-cache pkgnames | sort | uniq | tr "\n" " "`

           # packages not installed
           packages=`grep -Fxv -f <(pkg ls) <(pkg list-available)`
           ;;
         rm|remove|autoremove|-d)
            # packages=`dpkg-query -l | grep '^ii' | awk '{print $2}' | sort | uniq | tr "\n" " "`
            cache=$HOME"/.cache/pkg.cache"
            dpkg-query -l | grep '^ii' | awk '{print $2}' > $cache
            snap list | awk '{print $1}' | tail -n +2 >> $cache
            flatpak list | awk '{print $1}' | tail -n +2 >> $cache
            packages=`cat $cache | sort | uniq | tr "\n" " "`
           ;;
       esac
       COMPREPLY=($(compgen -W "$packages" -- $cur))
       return 0;
     fi
    return 0
  fi
}

complete -F _pkg -o filenames pkg
