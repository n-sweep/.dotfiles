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

# nixos-rebuild
alias build="sudo nixos-rebuild switch --impure --flake ~/.dotfiles/nixos#xps"

# venv activation
alias activate="source ./.venv/bin/activate"
alias venv='if [[ -n $VIRTUAL_ENV_PROMPT ]]; then deactivate; elif [ -d "./.venv" ]; then source ./.venv/bin/activate; elif [ -d "./venv" ]; then source ./venv/bin/activate; else echo "no environment found"; fi'

# setup monitors
alias mon3="xrandr --output DP-2 --primary --rotate right --output DP-3 --right-of DP-2 --output eDP-1 --right-of DP-3"

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
alias obs="obs-cli --password='$(head -1 "$HOME/.config/obs-studio/token")'"
alias camstat="obs sceneitem toggle Camera static"
alias cam="obs sceneitem toggle Camera zerocam"
alias mute="obs source toggle-mute Mic/Aux"
alias dtmute="obs source toggle-mute 'Desktop Audio'"

function obs_switch_scene() {
    obs scene current "$*" > /dev/null
}
function obs_toggle_blur() {
    local curr="$(obs scene get)"
    if [[ $curr == *" b" ]]; then
        obs scene current "$(obs scene get | sed 's/ [^ ]*$//')" > /dev/null
    else
        obs scene current "$(obs scene get) b" > /dev/null
    fi
}
function streamsaver() {
    cam
    mute
    obs_switch_scene one
    if ! $(tmux list-panes -F '#F' | rg -q Z); then
        tmux resize-pane -Z
    fi
    if [ -n "$*" ]; then
        cbonsai -S -t 0.7 -w 2 -m "$*"
    else
        cbonsai -S -t 0.7 -w 2
    fi
}

alias switch="obs_switch_scene"
alias blur="obs_toggle_blur"
alias sbreak="streamsaver"
