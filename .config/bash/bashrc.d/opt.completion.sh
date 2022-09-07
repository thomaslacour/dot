# -- completion:git
source /usr/share/bash-completion/completions/git


# -- completion:SSH
#       Add tab completion for SSH hostnames based
#       on $HOME/.config/ssh/config, ignoring wildcards
#       https://github.com/pahen/dotfiles/blob/master/.completions#L26
[ -e $SSH_CONFIG ] && complete -o default -o nospace -W "$(grep "^Host" $SSH_CONFIG | grep -v "[?*]" | cut -d " " -f2)" scp sftp ssh


# -- completion:KILL
#       Add case-insensitive `kill` tab completion of running apps
_complete_running_processes_pids ()
{
    local re
    local LC_ALL='C'
    local IFS=$'\n'
    local cur=${COMP_WORDS[COMP_CWORD]}

    COMPREPLY=()

    # do not attempt completion if we're specifying an option
    [[ "$cur" == -* ]] && return 0

    # Escape dots in paths for grep
    cur=${cur//\./\\\.}

    if [[ $cur != *[!0-9]* ]]; then
        # search by PID
        re="^$cur"
    else
        # search by process name
        re="^[0-9]+ # $cur[^$]"
    fi

    COMPREPLY=( $(ps axc | tail -n +2 | awk '{print $1 " # " $5}' | sort -u | grep -v "^[\-\(]" | egrep -i "$re") )
}
complete -o bashdefault -o default -o nospace -F _complete_running_processes_pids kill


# -- completion:KILLALL
#       Add case-insensitive `killall` tab completion of running apps
_complete_running_processes ()
{
    local LC_ALL='C'
    local IFS=$'\n'
    local cur=${COMP_WORDS[COMP_CWORD]}

    COMPREPLY=()

    # do not attempt completion if we're specifying an option
    [[ "$cur" == -* ]] && return 0

    # Escape dots in paths for grep
    cur=${cur//\./\\\.}

    COMPREPLY=( $(ps axc | tail -n +2 | awk '{ print $5 }' | sort -u | grep -v "^[\-\(]" | grep -i "^$cur") )
}
complete -o bashdefault -o default -o nospace -F _complete_running_processes killall
