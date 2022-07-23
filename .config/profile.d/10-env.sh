# ┌───────────────────────── ─ ─   ─
# │ ~/.config/profile
# └───────────────────────── ─ ─   ─

# ····· clean ~/
export PASSWORD_STORE_DIR="$XDG_DATA_HOME/password-store"
# export GNUPGHOME="$XDG_CONFIG_HOME"/gnupg # gpg2 --homedir "$XDG_DATA_HOME"/gnupg
export SUBVERSION="$XDG_CONFIG_HOME"/subversion
export INPUTRC="$XDG_CONFIG_HOME"/inputrc

# ····· editor
export EDITOR="vim"
export VIMINIT='let $MYVIMRC="$XDG_CONFIG_HOME/vim/vimrc" | source $MYVIMRC'
export EXINIT="" # ex editor rc load at viminit

# ····· pager
export PAGER="less"
export LESSHISTFILE=-

# ····· color
export TERM=xterm-256color
export GREP_COLORS='38;5;200'

# ····· x11
# export USERXSESSION="$XDG_CACHE_HOME/X11/xsession"
# export USERXSESSIONRC="$XDG_CACHE_HOME/X11/xsessionrc"
# export ALTUSERXSESSION="$XDG_CACHE_HOME/X11/Xsession"
# export ERRFILE="$XDG_CACHE_HOME/X11/xsession-errors"


# ····· python
export PYENV_ROOT="$XDG_DATA_HOME"/pyenv
export PYENV_VIRTUALENV_DISABLE_PROMPT=1
export PYTHONSTARTUP="$XDG_CONFIG_HOME"/python/startup.py
export IPYTHONDIR="$XDG_CONFIG_HOME"/jupyter
export JUPYTER_CONFIG_DIR="$XDG_CONFIG_HOME"/jupyter


# ····· npm
export NPM_CONFIG_USERCONFIG="$XDG_CONFIG_HOME"/npm/npmrc
