# ┌───────────────────────── ─ ─   ─
# │ ~/.config/bashrc.d/aliases.sh
# └───────────────────────── ─ ─   ─

# damage prevention
alias chmod='chmod --preserve-root'
alias dd='echo "no dd command available (disabled in aliases)"'

## show my mf*path
alias path='echo $PATH | tr : \\n'

# show my repo for apt
alias repos='grep ^ /etc/apt/sources.list /etc/apt/sources.list.d/*'

# show my public ip
alias myip='curl ipinfo.io/ip 2> /dev/null'

# ls commands
alias ls-pip-packages="find $VIRTUAL_ENV/* -maxdepth 4 -name __init__.py 2> /dev/null"
alias ls-app-desktop="find / -name '*.desktop' 2> /dev/null"
alias ls-lightdm-conf-files="find / -name 'lightdm' 2> /dev/null"

# moving is so easy
alias ~="cd ~"
alias ..="cd .."
alias ...="cd ../.."
#alias .="dir"  # problems with bash completions
alias q="exit"

# colors
alias grep='grep --color=auto'

# no color and show directory at the top
alias ls="\ls --color='none' --group-directories-first"

# list only directory
alias ld="ls -ld */"

# list all
alias ll='ls -lArth'

# avoid anoying history file
alias wget="wget --hsts-file '/dev/null'"

# show the current meteo
alias meteo="curl 'wttr.in/bordeaux?0Q'"

# xdg specification
#alias tmux="tmux -f $XDG_CONFIG_HOME'/tmux/tmux.conf'"
# alias ssh='ssh -F $XDG_CONFIG_HOME/ssh/config -i $XDG_DATA_HOME/ssh/id_rsa -o UserKnownHostsFile=$XDG_DATA_HOME/ssh/known_hosts'

# always call vim!
vi () {
  command -v vim && vim -p "$@"
}

refresh () {
  case $1 in
  # if [ "$1" == "bashrc" ] ; then
  bashrc|--shell|-s)
    source $BASHRC > /dev/null 2>&1
    echo "bashrc, refreshing done !"
    return 0
    ;;
  # elif [ "$1" == "fontcache" ] ; then
  #   refresh '.local/share/fonts'
  fontcache|--font|-f)
    fc-cache -f -v > /dev/null 2>&1
    echo "font cache refreshed !"
    return 0
    ;;
  # else
  *)
    echo "what ?"
    ;;
  # fi
  esac
}


alias git_branch="git rev-parse --abbrev-ref HEAD 2> /dev/null"

git () {
  if [ "$PWD" == "$HOME" ] ; then
    /usr/bin/git --git-dir=$HOME/.dot --work-tree=$HOME "$@"
  else
    /usr/bin/git "$@"
  fi
}

pkg () {
  pkg.sh ${@}
}
