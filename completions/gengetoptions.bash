# Bash completion for gengetoptions
#
# INSTALLATION
#
# First install gengetoptions from
# https://github.com/ko1nksm/getoptions
#
# Then copy this file into a lazy-loading bash-completion folder:
#
#     "${XDG_DATA_HOME}"/bash-completion/completions/
#     /usr/local/share/bash-completion/completions/
#     /usr/share/bash-completion/completions/
#
# or copy it into a preloading bash_completion folder:
#
#     /etc/bash_completion.d/
#     ~/bash_completion.d/
#
# or copy it somewhere (e.g. ~/.gengetoptions.bash) and put the
# following in your .bashrc:
#
#     source ~/.gengetoptions.bash
#
# CREDITS
#
# Written by foomin10 <foomin10@gmail.com>

_gengetoptions()
{
    local cur prev words cword command=
    local -a req_arg=()
    _init_completion || return

    for ((i = 1; i < cword; i++)); do
        if [[ "${words[i]}" != -* ]]; then
            command="${words[i]}"
            break
        fi
    done

    case "$command" in
        "")
            COMPREPLY=($(compgen -W '--info --help --version library parser embed example' -- "${cur}"))
            ;;
        library)
            COMPREPLY=($(compgen -W '-i --help --indent --no-abbr --no-base --no-comments --no-help --optarg= --optind= --shellcheck' -- "${cur}"))
            ;;
        parser)
            compopt -o default
            COMPREPLY=($(compgen -W '-f -i --definition= --file= --help --indent --no-comments --optarg= --optind= --shellcheck ${req_arg[@]}' -- "${cur}"))
            ;;
        embed)
            compopt -o default
            COMPREPLY=($(compgen -W '-e -w --erase --help --overwrite' -- "${cur}"))
            ;;
        *)
            COMPREPLY=()
            ;;
    esac

    [[ "${COMPREPLY-}" == *= ]] && compopt -o nospace

    return 0
}

complete -F _gengetoptions gengetoptions
