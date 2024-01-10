#!/bin/bash
# Create a new jupyter nb from template file

export PATH="$PATH:$HOME/.local/bin"

# TODO: a way to select from multiple templates
tmp="temp"

base_cmd="jupytext --to notebook $HOME/.dotfiles/jupyter/templates/$tmp.py"

# if the user provides a name, use it else use the tempate's name
fn="$tmp"
if [ -n "$1" ]; then
    fn="${1%.ipynb}"
fi

eval "$base_cmd -o $(pwd)/$fn.ipynb"
