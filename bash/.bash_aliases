DOTFILES_DIR="$HOME/.dotfiles"
SCRIPTS_DIR="$DOTFILES_DIR/scripts"

alias c=clear

# copy/paste
alias pst="xclip -o -selection clipboard"
alias cpy="xclip -i -selection clipboard"

dots="."
path="cd "
for _ in {1..5}; do
    dots="${dots}."
    path="${path}../"
    alias "$dots"="$path"
done

# lock screen
alias lock="i3lock -c 000000"

# neovim
alias vim=nvim
alias vi=nvim

# docker
alias docker="sudo docker"

# fastfetch
rand_dist() {
    # randombly choose an icon for fastfetch
    dists="windows macos"
    echo "$dists" | tr ' ' '\n' | shuf -n 1
}
alias cn="c && fastfetch --logo \$(rand_dist)"

# venv activation
alias activate="source ./.venv/bin/activate"
alias venv='if [[ -n $VIRTUAL_ENV_PROMPT ]]; then deactivate; elif [ -d "./.venv" ]; then source ./.venv/bin/activate; elif [ -d "./venv" ]; then source ./venv/bin/activate; else echo "no environment found"; fi'

# select a window to "paste" into with xdotool
alias typepaste="nix-shell -p xdotool --run \"xdotool windowfocus \\\$(xdotool selectwindow); xdotool type \$(pst)\""

### script aliases #############################################################

# search
alias q="duck"
alias qq="gippity"

# Jupytext create new notebook
alias nnb="$SCRIPTS_DIR/create_nb"

alias n="daily_note"
alias today="vim -c :ObsidianToday"


### git ########################################################################

alias gs="git status"
alias ga="git add"
alias gc="git commit -m"


### tmux #######################################################################

# startup / reattach script
alias tm="tmux_startup"

# quick reattach
alias ta="tmux a"

# tmux-sessionizer
alias ts="$SCRIPTS_DIR/tmux_sessionizer"


### obs ########################################################################

if which obs-cmd &> /dev/null; then
    source $DOTFILES_DIR/bash/obs
fi
