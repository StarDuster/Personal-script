#!/bin/bash
# Usage: fuzzyssh.sh [ssh option] [keyword1] [keyword2]
# search keyword reversely in ~/.ssh
# display all matchs and choose one to connect

PATH=/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin
USERDIR=~

shopt -s expand_aliases
declare -a hosts
declare -a new_hosts
declare -a ssh_opts
declare -a ssh_args
declare -a keywords

alias grep="grep --exclude=${USERDIR}/.ssh/known_hosts \
            --exclude=${USERDIR}/.ssh/*id* \
            --exclude=${USERDIR}/.ssh/multiplex \
            --exclude=${USERDIR}/.ssh/authorized_keys"

show_help()
{
    echo "Usage: fuzzyssh.sh [ssh option] [keyword1 | IP | hostname] [keyword2]... "
    echo "      [-46AaCfGgKkMNnqsTtVvXxYy] [-B bind_interface] "
    echo "      [-b bind_address] [-c cipher_spec] [-D [bind_address:]port] "
    echo "      [-E log_file] [-e escape_char] [-F configfile] [-I pkcs11] "
    echo "      [-i identity_file] [-J [user@]host[:port]] [-L address] "
    echo "      [-l login_name] [-m mac_spec] [-O ctl_cmd] [-o option] [-p port] "
    echo "      [-Q query_option] [-R address] [-S ctl_path] [-W host:port] "
    echo "      [-w local_tun[:remote_tun]] destination [command] " 
}

parse_option()
{
    while getopts ":46AaCfGgKkMNnqsTtVvXxYy:B:b:c:D:E:e:F:I:i:J:L:l:m:O:o:p:Q:R:S:W:w:" optname
    do
        case "${optname}" in
            B|b|c|D|E|e|F|I|i|J|L|l|m|O|o|p|Q|R|S|W|w)
                ssh_args+=(-$optname $OPTARG) ;;
            4|6|A|a|C|f|G|g|K|k|M|N|n|q|s|T|t|V|v|X|x|Y|y)
                ssh_opts+=(-$optname) ;;
            *) echo -e "Wrong option " && show_help && exit 1 ;;
        esac
    done

    shift $((OPTIND - 1))

    while [ $# -gt 0 ]; do
        keywords+=($1) && shift
    done
}

search_keywords()
{
    hosts=($(grep -r $1 -- ${USERDIR}/.ssh | awk '{ print $2}'))
    new_hosts=()
    length=${#keywords[@]}

    for i in `seq 0 $(($length-1))`; 
    do
        for j in "${!hosts[@]}"; do
            if echo ${hosts[$j]} | grep -q "${keywords[$i]}";then
                new_hosts+=(${hosts[$j]})
            else
                :
            fi
        done
        i=$((i+1))
        hosts=(${new_hosts[@]})
        new_hosts=()
    done
}

connect_hosts()
{
    if echo ${keywords[0]} | grep -qE "\b([0-9]{1,3}\.){3}[0-9]{1,3}\b"; then
        echo -e "\nExec ssh ${ssh_args[@]} ${ssh_opts[@]} ${keywords[0]}\n"  
        ssh ${ssh_args[@]} ${ssh_opts[@]} ${keywords[0]}  
    else
        search_keywords ${keywords[@]} 
    fi

    if [ ${#hosts[@]} -eq 1 ]; then
        echo -e "\nExec ssh ${ssh_args[@]} ${ssh_opts[@]} ${hosts[0]}\n"
        ssh ${ssh_args[@]} ${ssh_opts[@]} ${hosts[0]} 
    elif [ -n "$hosts" ]; then 
        for i in "${!hosts[@]}"; do
            printf "%s\t%s\n" "$i" "${hosts[$i]}"
        done
        read -p "Choose which one to connect" id 
        id=${id:-0}
        echo -e "\nExec ssh ${ssh_args[@]} ${ssh_opts[@]} ${hosts[$id]}\n"
        ssh ${ssh_args[@]} ${ssh_opts[@]} ${hosts[$id]}
    else
        echo "No host found" && exit 1
    fi
}

parse_option "$@"
connect_hosts

