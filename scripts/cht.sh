#!/usr/bin/env bash

base_list=`curl -s "cht.sh/:list"`
root=`echo $base_list | tr ' ' '\n' | fzf`
read -p "query: " query

# check if the root is a language
lang=`curl -s "cht.sh/{$root}/:list"`

if [ ! "$lang" ]; then
    tmux neww bash -c "curl cht.sh/$root~`echo $query | tr ' ' '+'` & while [ : ]; do sleep 1; done"
else
    tmux neww bash -c "curl cht.sh/$root/`echo $query | tr ' ' '+'` & while [ : ]; do sleep 1; done"
fi
