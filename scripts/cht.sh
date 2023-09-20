#!/usr/bin/env bash

# fzf init (because .bashrc hasn't run yet?)
[ -f ~/.fzf.bash ] && source ~/.fzf.bash

# define the root of the search and check if it is a language
local root=$(echo curl -s "cht.sh/:list" | tr ' ' '\n' | fzf)
local lang=`curl -s "cht.sh/{$root}/:list"`
local sep

# languages and system tools have slightly different query syntax
if [ ! "$lang" ]; then
    sep="~"
else
    sep="/"
fi

read -p "query: " query
tmux neww bash -c "curl cht.sh/$root$sep`echo $query | tr ' ' '+'` & while [ : ]; do sleep 1; done"

