#!/bin/bash

function update_repo()
{
    if [ -f $1 ]; then
        if [ $# -eq 2 ]; then
            export http_proxy=http://10.8.0.1:8118
        else
            export http_proxy=
        fi
        echo ">>> updating $1..."
        apt-get update --fix-missing -o Dir::Etc::sourcelist="$1" -o Dir::Etc::sourceparts="-" -o APT::Get::List-Cleanup="0"
    fi
}

update_repo /etc/apt/sources.list
update_repo /etc/apt/sources.list.d/puppetlabs-pc1.list

for f in `ls /etc/apt/sources.list.d/ppa-*.list`; do
    update_repo $f --fk-gfw
done
