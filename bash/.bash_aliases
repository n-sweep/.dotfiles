alias c=clear

alias q="$HOME/.dotfiles/scripts/duck"
alias qq="$HOME/.dotfiles/scripts/gippity"
alias pst="xclip -o -selection clipboard"

# zettelkasten
alias zk="cd $HOME/.zettelkasten/ && nvim index.md"

# tmux startup / reattach script
alias tm="$HOME/.dotfiles/scripts/tmux_startup"
# tmux quick reattach
alias ta="tmux a"

# Jupytext create new notebook
alias nnb="$HOME/.dotfiles/jupyter/create_nb.sh"

### obs ########################################################################
alias obs="obs-cli -q -p='$(head -1 "$HOME/.config/obs/token")'"
alias stat="obs item toggle 'Static' --scene 'Camera'"
alias cam="obs item toggle 'Camera Mask' --scene 'one'"

function obs_switch_scene() {
    obs scene switch "$*" > /dev/null
    obs scene current
}
function obs_toggle_blur() {
    local curr="$(obs scene current)"
    if [[ $curr == *" b" ]]; then
        obs scene switch "$(obs scene current | sed 's/ [^ ]*$//')" > /dev/null
    else
        obs scene switch "$(obs scene current) b" > /dev/null
    fi
    obs scene current
}

alias switch="obs_switch_scene"
alias blur="obs_toggle_blur"

# dot navigation aliases
dot_nav() {
    local dots="." path="cd "
    for i in {1..5}; do
        dots="${dots}."
        path="${path}../"
        alias "$dots"="$path"
    done
}
dot_nav
