### .bashrc defaults ###################################################

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    alias grep='grep --color=auto'
fi

# Alias definitions.

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi


### history settings ###################################################

# append to the history file, don't overwrite it
shopt -s histappend

# time format
HISTTIMEFORMAT="%Y-%m-%d %H:%M:%S "

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=10000
HISTFILESIZE=10000

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignorespace:erasedups


### smart prompt #######################################################
# adapted from angery rob >:(

PROMPT_LONG=30
__ps1() {
	# color vars
	local P='»' cwd="${PWD}" estus="$?"\
        B C D G countme conda_env git_root addr path prompt \
		r='\[\e[31m\]' g='\[\e[32m\]' y='\[\e[33m\]' \
		u='\[\e[34m\]' p='\[\e[35m\]' c='\[\e[36m\]' \
		w='\[\e[37m\]' a='\[\e[90m\]' x='\[\e[0m\]' \
		bold='\[\e[1m\]' ital='\[\e[2m\]'

    # the plaintext length of the prompt needs to be counted without formatting
    # strings. we will add to this as we go to be counted at the end
    countme="$USER@$(hostname):"

	# replace $ with # if root
	[[ $EUID == 0 ]] && P='#'

    # are we in a git repo
	git_root="$(git rev-parse --show-toplevel 2>/dev/null)"
	if [[ -n "$git_root" ]]; then
		# git branch name
		B=$(git branch --show-current 2>/dev/null)
        # is repo dirty
        D="$(git diff --quiet --ignore-submodules HEAD &>/dev/null; [ $? -eq 1 ] && echo "*")"

        [[ -n "$B" ]] && B=" g:$B$D"

        git_root_base="$(basename $git_root)"
        # count the unformatted cwd to ignore escape strings
		countme+="$git_root_base${cwd##$git_root}"
        # formatted cwd
		cwd="$bold$git_root_base$x$u${cwd##$git_root}"
	else
		cwd="${cwd/#$HOME/\~}"
        countme+=$cwd
	fi

    # get name of conda environment if exists
    [[ -n "$CONDA_PROMPT_MODIFIER" ]] && C=" c:${CONDA_PROMPT_MODIFIER//[\(\) ]/}"

    # if we have branch or conda env data, add to G
    [[ -n "$B" || -n "$C" ]] && G="$ital$a$B$C$x"

	addr="$y\u$w@$c\h$w"
	path="$u$cwd$G"
    prompt="$(if [ $estus -eq 0 ]; then echo -n $p; else echo -n $r; fi)$P$x "
    countme+="$B$C $P "

	if ((${#countme} < PROMPT_LONG)); then
		# short
		PS1="$addr:$path $prompt"
	else
		# long
		PS1="\n$path\n$addr $prompt"
	fi
}

PROMPT_COMMAND="__ps1"


### personal settings ##########################################################
# note: aliases are in .bash_aliases

set -o vi  # vi mode!
shopt -s expand_aliases

# nvim as default editor
# [TODO]: check for nvim, fall back on vim, vi
export EDITOR=nvim

# open tmux automatically
# if sessions exist, reattach, otherwise run tmux startup script
if [ -z "$TMUX" ] && [ ! -n "$SSH_CONNECTION" ]; then
    if tmux list-sessions 2>/dev/null; then ta; else tm; fi
fi

# fzf init
[ -f ~/.fzf.bash ] && source ~/.fzf.bash

export FZF_DEFAULT_COMMAND='find -L . -type f \( ! -path '*/.git/*' -o -path '*/.git' -prune \)'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

# bash scripts path
export PATH="$PATH:$HOME/.dotfiles/scripts"

# go path
export GOPATH="$HOME/go/bin"
export PATH="$PATH:$GOPATH"

# mojo path
export MODULAR_HOME="$HOME/.modular"
export PATH="$HOME/.modular/pkg/packages.modular.com_mojo/bin:$PATH"

# run neofetch on startup
clear && neofetch


### anaconda initialization ####################################################

# exit the script before conda initialize unless $CONDA_INIT is set
# I set $CONDA_INIT in a tmux startup script to control where conda initializes
if [ -z "$CONDA_INIT" ]; then return 0; fi

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$("$HOME/anaconda3/bin/conda" 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "$HOME/anaconda3/etc/profile.d/conda.sh" ]; then
        . "$HOME/anaconda3/etc/profile.d/conda.sh"
    else
        export PATH="$HOME/anaconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<
