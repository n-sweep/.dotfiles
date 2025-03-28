SCRIPTS_DIR="\$HOME/.dotfiles/scripts"

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
# https://github.com/grigio/obs-cmd
alias obs-studio="\$(which obs)"
alias obs="obs-cmd --websocket obsws://localhost:4455/\$(head -1 \$HOME/.config/obs-studio/token)"
alias cam="obs scene-item toggle cam zerocam &> /dev/null"
alias blur="obs scene-item toggle desktop1 'HDMI-0 blur' &> /dev/null"
alias camstat="obs scene-item toggle cam static &> /dev/null"
alias mute="obs toggle-mute Mic/Aux &> /dev/null"
alias dtmute="obs toggle-mute 'Desktop Audio' &> /dev/null"
alias sbreak="streamsaver &> /dev/null"
alias switch="obs scene switch"
alias sw="switch"

function streamsaver() {
    cam && mute
    if [ -n "$*" ]; then
        tmux neww -n cbonsai cbonsai -S -t 0.7 -w 2 -m "$*"
    else
        tmux neww -n cbonsai cbonsai -S -t 0.7 -w 2
    fi
    while tmux list-windows | rg -q cbonsai; do
        sleep 1
    done
    cam && mute
}

