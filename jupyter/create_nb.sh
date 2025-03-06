#!/usr/bin/env bash
# Create a new jupyter nb from template file

usage="Usage: $(basename "$0") [-t] [new_file_name]"
tmp="default"

while getopts 't:h' opt; do
    case "$opt" in
        t) tmp="$OPTARG";;
        h) echo "$usage"; exit 0;;
        ?) echo "Invalid option. $usage"; exit 1;;
    esac
done

# drop processed arguments
shift $((OPTIND-1))

base_cmd="jupytext --to notebook $HOME/.dotfiles/jupyter/templates/$tmp.py"

# if the user provides a name, use it else use the tempate's name
fn="temp"
if [ -n "$1" ]; then
    fn="${1%.ipynb}"
fi

eval "$base_cmd -o $(pwd)/$fn.ipynb"
