alias c=clear

# copy/paste
alias pst="xclip -o -selection clipboard"
alias cpy="xclip -i -selection clipboard"

# dot navigation aliases
dots="."
path="cd "
for i in {1..5}; do
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
    echo $dists | tr ' ' '\n' | shuf -n 1
}
alias cn="c && fastfetch --logo $(rand_dist)"

# venv activation
alias activate="source ./.venv/bin/activate"
alias venv='if [[ -n $VIRTUAL_ENV_PROMPT ]]; then deactivate; elif [ -d "./.venv" ]; then source ./.venv/bin/activate; elif [ -d "./venv" ]; then source ./venv/bin/activate; else echo "no environment found"; fi'

# setup monitors
alias mon3="xrandr --output DP-3 --primary --rotate right --output DP-2 --right-of DP-3 --output eDP-1 --right-of DP-2"

### script aliases #############################################################

# scripts are symlinked to ~/bin

# search
alias q="duck"
alias qq="gippity"

# daily journal
alias journal="zk '# \d+ Daily Journal'"

# Jupytext create new notebook
alias nnb="$HOME/.dotfiles/jupyter/create_nb.sh"


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
alias ts="$HOME/.dotfiles/scripts/tmux_sessionizer"


### obs ########################################################################
# https://github.com/grigio/obs-cmd
alias obs-studio="$(which obs)"
alias obs="obs-cmd --websocket obsws://localhost:4455/$(head -1 "$HOME/.config/obs-studio/token")"
alias cam="obs scene-item toggle cam zerocam &> /dev/null"
alias blur="obs scene-item toggle desktop1 'HDMI-0 blur' &> /dev/null"
alias camstat="obs scene-item toggle cam static &> /dev/null"
alias mute="obs toggle-mute Mic/Aux &> /dev/null"
alias dtmute="obs toggle-mute 'Desktop Audio' &> /dev/null"
alias sbreak="streamsaver &> /dev/null"

function streamsaver() {
    cam && mute
    if ! $(tmux list-panes -F '#F' | rg -q Z); then
        tmux resize-pane -Z
    fi
    if [ -n "$*" ]; then
        cbonsai -S -t 0.7 -w 2 -m "$*"
    else
        cbonsai -S -t 0.7 -w 2
    fi
}

