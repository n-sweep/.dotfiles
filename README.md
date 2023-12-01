# .dotfiles
### Using `GNU Stow` to symlink files into home folder  
0. install `stow`
    ```sh
    sudo apt update && sudo apt install -y stow 
    ```

1. `git clone` repo into home folder   
    ```sh
    cd && git clone https://github.com/n-sweep/.dotfiles
    ```
1. cd into `.dotfiles` and `stow` the desired directory
    ```sh
    stow `dirname` -d ~/.dotfiles -t ~
    ```
    > default behavior symlinks the directory to the parent of your current directory

## Table of Contents

1. [`README.md`](#README.md)
1. [`bash`](#bash)
	1. [`.bash_aliases`](#.bash_aliases)
	1. [`.bashrc`](#.bashrc)
	1. [`.inputrc`](#.inputrc)
1. [`cl_zsh/.zshrc`](#cl_zsh/.zshrc)
1. [`firefox`](#firefox)
1. [`journals`](#journals/vim.md)
1. [`jupyter`](#jupyter)
1. [`noted`](#noted/.notedconfig)
1. [`nvim`](#nvim/.config)
1. [`scripts`](#scripts)
1. [`tmux`](#tmux)
1. [`wezterm`](#wezterm)
1. [`zsh`](#zsh)


## `README.md`
This file.

## `bash/`
Bash settings and aliases

This directory gets symlinked to the home folder:
```sh
stow bash -d ~/.dotfiles -t ~
```

### `.bash_aliases`
Bash aliases:
```
### misc #######################################################################
c           clear
datedir     create a directory with today's date + a README.md inside
nnb         create a new jupyter notebook with JupyText
pst         paste from clipboard
q           duck duck go
qq          chat gpt
ta          tmux quick reattach
tm          tmux startup / reattach
zk          open zettelkasten in nvim

### obs ########################################################################

obs         alias for obs-cli w/ quiet flag and security token
            "$HOME/.config/obs/token"
cam         toggle camera
camstat     toggle camera static
switch      switch to scene (arg)
blur        toggle blur
```

### `.bashrc`
1. default bash settings
    1. some settings retained from ubuntu's bash defaults
1. smart prompt
    1. adapted from angery rob >:( (github.com/rwxrob)
    1. adjust format depending on length
    1. show conda environment
    1. show git branch
1. personal settings
    1. vi mode!
    1. `shopt -s expand_aliases` I don't remember what this does
    1. open tmux automatically
    1. fzf initialization
        1. ctrl + R for command history
        1. ctrl + T for file/dir fzf
    1. paths
        1. bash scripts
        1. go
        1. mojo
    1. clear & run neofetch
1. anaconda initialization (automatically generated)

### `.inputrc`
1. change cursor depending on vi mode
1. completion settings


## `cl_zsh/.zshrc`
> [DEPRICATED] laid off lol


## `firefox/`

#### Firefox Cuscomization
Customize firefox to use an image on the system in a blank tab

1. visit `about:support` 
1. locate Application Basics > Profile Directory
    - `/home/n/.mozilla/firefox/l7f2epeq.default-release-1695236326892`
    - this looks like it will change, maybe when firefox is updated. I wonder if there is a way to get it programatically
1. stow the ./chrome folder to the Profile Directory
    ```sh
    stow chrome -d ~/.dotfiles/firefox -t ~/.mozilla/firefox/l7f2epeq.default-release-1695236326892
    ```
1. copy an image to the file /usr/share/backgrounds/wallpaper to be used as the newtab wallpaper

> **[TODO]** I also have a firefox setting that shrinks the UI. I forget what it is; find and document

### `chrome/userContent.css`
CSS for setting blank tab background image

## `journals/vim.md`
vim stuff to work on

> **[TODO]** Depricate - this should be moved to / removed in favor of the zettelkasten


## `jupyter/`
Settings for jupyter

#### Jupyter notebook themes
```sh
pip install jupyterthemes
pip install --upgrade jupyterthemes

jt -t gruvboxd -f ubuntu -nfs 11 -T -N -kl
```

### `create_nb.sh`
Use JupyText to create a new jupyter notebook based on a template

> **[TODO]** should I move the script to scripts/ instead of jupyter/

### `templates/`
Notebook templates

    temp.py


## `noted/.notedconfig`
> [DEPRICATED] in favor of zettelkasten.

> **[TODO]** uninstall noted


## `nvim/.config/`
The parent directory gets stowed to the home folder

```sh
stow nvim -d ~/.dotfiles -t ~
```

### `pycodestyle`
code style settings
> ignoring E501, E116

### `nvim/`
This directory contains lua to be run by neovim at startup

```sh
init.lua  # entrypoint - runs automatically at startup
lua/
    nsweep/  # my user settings
        init.lua
        plugin.lua
        remap.lua
        set.lua
    keysender/  # send keys from neovim to tmux pane
        init.lua
        README.md
    slipbox/  # zettelkasten navigator
        assets.lua
        init.lua
        keymap.lua
        README.md
after/plugin/  # lua run automatically after nvim loads
    colorscheme.lua
    harpoon.lua
    jupynium.lua
    jupytext.lua
    lsp.lua
    lualine.lua
    markdown-preview.lua
    nvim-autopairs.lua
    telescope.lua
    tmux.lua
    treesitter.lua
    undotree.lua
    vim-fugitive.lua
```


## `scripts/`
This directory contains (primarily bash) scripts

### `path/`
Scripts in this directory get symlinked to `~/bin`

```sh
stow path -d "~/.dotfiles/scripts" -t "$HOME/bin" 
# OR the alias
# stowpath 
```

### Small scripts

- scratch
    - cd into /tmp/scratch/ and run nvim. mkdir if it doesn't exist.
- stowpath
    - stows everything from ~/.dotfiles/scripts/path to ~/bin

#### `emoji`
an emoji command line tool using [Open Emoji API](https://emoji-api.com/), `fzf`, and `ripgrep`

```sh
# echo emoji to terminal
$ emoji waving hand
> 👋

# copy emoji to clipboard
$ emoji -c waving hand

# replace multiple emoji with :colon-syntax:
$ emoji -m "an :avocado: is a fruit. so is a :tomato:. they do not belong in a fruit salad. :grinning-face-with-sweat:"
> an 🥑 is a fruit. so is a 🍅. they do not belong in a fruit salad. 😅

$ echo "an :avocado: is a fruit.\nso is a :tomato:.\nthey do not belong in a fruit salad. :grinning-face-with-sweat:" > /tmp/text.txt
$ emoji -m "$(cat /tmp/text.txt)"
> an 🥑 is a fruit
> so is a 🍅
> they do not belong in a fruit salad 😅
```

## `tmux/`
This directory gets symlinked to the home folder

```sh
stow tmux -d ~/.dotfiles -t ~
```

### `.tmux.conf`
> **[TODO]** document

### `tmux_status_right`
> **[TODO]** document


## `wezterm/`
This directory gets symlinked to the home folder

```sh
stow wezterm -d ~/.dotfiles -t ~
```

### `.wezterm.lua`
> **[TODO]** document


## `zsh/.zshrc`
> [DEPRICATED] in favor of bash
