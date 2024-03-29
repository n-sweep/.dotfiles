# .dotfiles

## Environment Setup

0. update system
    ```sh
    sudo apt update && sudo apt update -y && sudo autoremove
    ```

1. install `git`, `stow`, and others
    ```sh
    sudo apt install -y git stow tmux ripgrep openssh-server i3 htop xclip neofetch
    # (?) sudo apt install barrier
    ```

1. clone this repo & open this file
    ```sh
    cd && git clone https://github.com/n-sweep/.dotfiles
    vi ~/.dotfiles/README.md
    ```


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

Bash aliases

### `.bashrc`
1. default bash settings
1. history settings
1. smart prompt
1. personal settings
1. cl settings
1. anaconda initialization (automatically generated)

### `.inputrc`
1. change cursor depending on vi mode
1. completion settings


## `firefox/`

#### Firefox Cuscomization
Customize firefox to use an image on the system in a blank tab

1. navigate to `about:config`
1. find `toolkit.legacyUserProfileCustomizations.stylesheets` & toggle to `true`
1. navigate to `about:support` 
1. locate Application Basics > Profile Directory
    - `/home/n/.mozilla/firefox/ut79gu00.default-release`
    - this changes, maybe when firefox is updated. I wonder if there is a way to get it programatically
1. stow the ./chrome folder to the Profile Directory
    ```sh
    stow firefox -d ~/.dotfiles -t ~/.mozilla/firefox/ut79gu00.default-release
    ```
1. copy an image to the file /usr/share/backgrounds/wallpaper to be used as the newtab wallpaper

> **[TODO]** I also have a firefox setting that shrinks the UI. I forget what it is; find and document
1. navigate to `about:config`
1. find `perpx`
1. change to scale where 1 = 100%

### `chrome/userContent.css`
CSS for setting blank tab background image


## `i3/.config/i3/config`

This directory gets symlinked to the home folder:
```sh
mv .config/i3/config .config/i3/default_config.bak
stow i3 -d ~/.dotfiles -t ~
```

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
if [ ! -d "$HOME/bin" ]; then mkdir $HOME/bin; fi
stow path -d ~/.dotfiles/scripts -t $HOME/bin 
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
