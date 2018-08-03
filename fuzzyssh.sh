#!/bin/bash
# Usage: fuzzyssh.sh keyword
# search keyword reversely in ~/.ssh
# display all matchs and choose one to connect

PATH=/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin
userdir=~
declare -a hosts
alias grep="grep --exclude=$userdir/.ssh/known_hosts 
            --exclude=$userdir/.ssh/\*id
            --exclude=$userdir/.ssh/multiplex
            --exclude=$userdir/.ssh/authorized_keys"
hosts=($(grep -r $1 ~/.ssh | awk '{ print $2}'))
if [ ${#host[@]} -eq 0 ]; then
    ssh ${hosts[0]}
elif [ -n "$hosts" ]; then 
    for i in "${!hosts[@]}"; do
        printf "%s\t%s\n" "$i" "${hosts[$i]}"
    done
    read -p "Choose which one to connect" id 
    id=${id:-0}
    ssh ${hosts[$((id))]}
else
    echo "No host found"
fi
