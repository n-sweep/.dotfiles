#!/bin/bash

SESSION="_"
PYSESSION="py"

function session_exists {
    if tmux list-sessions | grep "$1"; then
        return 0
    else
        return 1
    fi
}

# Only start new sessions if they don't already exist

#
if [ -n $(session_exists $SESSION) ];
then
    # Start the first session
    tmux new-session -d -s $SESSION
    tmux rename-window -t 1 'main'

    # 1st session: open htop on the first pane and vertical split a new pane
    tmux send-keys -t 'main' 'htop' C-m
    tmux split-window -v

    # 1st session: open a new window in dotfiles
    tmux new-window -t $SESSION:2 -n 'dotfiles' -c $HOME/.dotfiles

    # 1st session: open a new window and start zettelkasten
    #tmux new-window -t $SESSION:3 -n 'zettelkasten'
    #tmux send-keys -t 'zettelkasten' 'zk' C-m
fi

if [ -n $(session_exists $PYSESSION) ];
then
    # Start a python session with conda
    tmux new-session -d -s $PYSESSION -e 'CONDA_INIT=True' -c '$HOME/Documents/Python/'
fi

# attach to session
tmux attach-session -t $SESSION:1
