alias c=clear

alias q="$HOME/.dotfiles/scripts/duck.sh"
alias qq="$HOME/.dotfiles/scripts/gippity.sh"

# zettelkasten
alias zk="cd $HOME/.zettelkasten/ && nvim index.md"

# tmux startup / reattach script
alias tm="$HOME/.dotfiles/scripts/tmux_startup.sh"
# tmux quick reattach
alias ta="tmux a"

# Jupytext create new notebook
alias nnb="$HOME/.dotfiles/jupyter/create_nb.sh"

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
