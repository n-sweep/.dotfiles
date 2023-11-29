#!/usr/bin/env bash

# fzf init (because .bashrc hasn't run yet?)
[ -f ~/.fzf.bash ] && source ~/.fzf.bash

# define the root of the search and check if it is a language
root=$(curl -s "cht.sh/:list" | fzf)

if [ -n "$root" ]; then
    # languages and system tools have slightly different query syntax
    lang=$(curl -s "cht.sh/{$root}/:list")
    if [ -n "$lang" ]; then sep="~"; else sep="/"; fi

    read -p "query: " query
    tmux neww bash -c "curl cht.sh/$root$sep`echo $query | tr ' ' '+'` & while [ : ]; do sleep 1; done"
fi
