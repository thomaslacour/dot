#!/usr/bin/env bash
# ┌───────────────────────── ─ ─   ─
# │ ~/.config/bash/bashrc.d/fetch.sh
# └───────────────────────── ─ ─   ─

# ····  shazam myself
# _nowplaying ()
# {
#   app=$(pacmd list-sink-inputs | grep process.binary | sed 's/.*\"\(.*\)\".*/\1/')
#   _icoplay="" # "♫ "
#   if [ "$(echo $app | sed 's/.*\(rhythmbox\).*/\1/g')" == "rhythmbox" ]; then
#     # -----[ rhythme box ]-----
#     title=$(pacmd list-sink-inputs | grep media.title | sed 's/.*\"\(.*\)\".*/\1/')
#     artist=$(pacmd list-sink-inputs | grep media.artist | sed 's/.*\"\(.*\)\".*/\1/')
#     np=$(rhythmbox-client --print-playing)
#     echo -n "$_icoplay$np "
#   elif [ "$app" == "brave" ]; then
#     # -----[ brave ]-----
#     echo -n "$_icoplay "
#   elif [ "$app" == cmus ]; then
#     # -----[ cmus ]-----
#     artist=$(cmus-remote -Q | grep 'tag artist' | cut -d' ' -f 3-)
#     track=$(cmus-remote -Q | grep 'tag title'  | cut -d' ' -f 3-)
#     [[ "$artist" == "" ]] || [[ "$track" == "" ]] && echo -n "$_icoplay?"
#     echo -n "$_icoplay$artist - $track "
#   elif [ "$app" == vlc ]; then
#     echo $(lsof -wc vlc | awk '$4~"[0-9]r" && $5=="REG"' | grep -o '[^/]*.mp3$')
#   else
#     echo -n ""
#   fi
# }


# # ····· how deep is your light ?
# local sysfs="/sys/class/backlight/intel_backlight"
# BRIGHTNESS=$(awk '{print $1/$2*100}' <<< "$(cat ${sysfs}/brightness) $(cat ${sysfs}/max_brightness)" | sed 's/\(.*\)\..*/\1/')


# ····· get OS and VER of the system
OS=$(lsb_release -si)
VER=$(lsb_release -sr)

# ····· HOST and USER
HOSTNAME=$(cat /proc/sys/kernel/hostname)
USERNAME=$USER

# ····· get my IP
PUBLIC_IP=$(dig @resolver4.opendns.com myip.opendns.com +short)
PRIVATE_IP=$(ip -o route get to 8.8.8.8 2> /dev/null | sed -n 's/.*src \([0-9.]\+\).*/\1/p')

# ····· the architect
case $(uname -m) in
  x86_64)
    ARCH=64
    ;;
  i*86)
    ARCH=32
    ;;
  *)
    ARCH=?
    ;;
esac


# ····· am I connected to the Matrix ?
_check_internet() {
  wget -q --spider http://google.com
  if [ $? -eq 0 ]; then
    echo 1
  else
    echo 0
  fi
}

# ····· FETCH
#         display a logo of a kitty cat and some cool infos
#         If connected to wifi "@" is displayed else "at"
#         If in a git repo, cat mouth change with modified and staged
fetch ()
{

  local d=$'\e[38;5;32m'
  local y=$'\e[38;5;80m'
  local m=$'\e[38;5;200m'
  local q=$'\e[38;5;166m'
  local j=$'\e[38;5;197m'
  local O=$'\e[38;5;208m'
  local p=$'\e[38;5;77m'
  local g=$'\e[38;5;239m'
  local t=$'\e[0m'

  local distrib=$(cat /etc/*-release 2> /dev/null | grep DISTRIB_ID | sed 's/.*=//')
  local wifiname="$(iwgetid | cut -d \" -f2)"
  local kernel="$(uname -r | cut -d '-' -f1)"
  local shell=$(basename $SHELL)$(if tmux info &> /dev/null; then echo '/tmux'; fi)
  _is_pkg() { command -v "$1" > /dev/null && echo "$1" ; }
  sep_pkg="/"
  case $distrib in
    solus ) #solus (eopkg)
      local packages=`_is_pkg eopkg`
      # packages+=`ls /var/lib/eopkg/package | wc -l`
      ;;
    elementary|ubuntu )
      local packages=`_is_pkg apt`
      # packages+=$(dpkg-query -l | grep '^ii' | awk '{print $2}' | wc -l)
      ;;
  esac
  packages+=${sep_pkg}`_is_pkg snap`
  # packages+=$(snap list | awk '{print $1}' | tail -n +2 | wc -l)
  packages+=${sep_pkg}`_is_pkg flatpak`
  # packages+=$(flatpak list | awk '{print $1}' | tail -n +2 | wc -l)
  pkgs_count=$(pkg ll | wc -l)
  local duhome=$(df -H / 2> /dev/null | tail -n1 | awk '{ print $5 }')
  local duroot=$(df -H /home 2> /dev/null | tail -n1 | awk '{ print $5 }')
  local folder=$(pwd | sed "s/$USER/\~/g" | sed "s/.*\///g")
  [ "$folder" = "" ] && folder="root"
  local wm=${XDG_CURRENT_DESKTOP}
  local ram=`free | awk '/Mem:/ {print int($3/$2 * 100.0)}'`
  local cpu=$(grep 'cpu ' /proc/stat | awk '{usage=($2+$4)*100/($2+$4+$5)} END {print usage}')

  local at=$([ -z "$wifiname" ] && echo "at" || echo "@" )
  local host=$([ -z "$wifiname" ] && echo $HOSTNAME || echo "${PUBLIC_IP}" )


  local o=" "
  local e=" "

  # git status
  if [ -n "$(git rev-parse --is-inside-work-tree 2> /dev/null)" ]; then
    local git=" ⎇ $t $(git rev-parse --abbrev-ref HEAD 2> /dev/null)$g"
    [ $(git status --porcelain | grep '??' | wc -l) -ne 0 ] && o="-" && e="$g?$t"
    [ $(git diff --staged --name-status | wc -l) -ne 0 ] && o="." && e=" "
    [ $(git ls-files --modified `git rev-parse --show-cdup` | wc -l) -ne 0 ] && o="O" && e="$j!$t"
  else
    local git=
  fi

  # python venv
  if [[ "$VIRTUAL_ENV" != "" ]]; then
    local PYVER=$(python --version | awk '{print "[" $2 "]"}')
    local venv="⟵ `basename \"$VIRTUAL_ENV\"`$PYVER"
  fi

clear

cat << EOF

        /\/\ $e   $y $t ${USERNAME}$g $at $t${host}$g$git in$t $folder
       (≽'$o')≼   $j $t ${OS}$g[$t$kernel$g]$t $g→$t $shell $p$venv$t
     l_( U U)    $q $t $m♥$t $g⟵ $t 🖿 $t$duhome $g🖿 $t$duroot$g
                   $d▢$t $g⟵ $t $pkgs_count   $g$packages$t

EOF

  return 0
}


# ····· show ls infos
info_tree() {

  # echo -e "\e[4m"$PWD"\e[0m"
  # ls -lrtX --group-directories-first --ignore={".",".."}
  tree -L 1 $PWD 2> /dev/null

  return 0

}


# ····· show git status
info_git() {

  if [ -n "$(git rev-parse --is-inside-work-tree 2> /dev/null)" ]; then
    echo -e " "
    git st
  fi

  return 0

}

about(){ fetch ;}

bind -x '";:": about'
