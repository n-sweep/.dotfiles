# .dotfiles

```sh
# Produce this table of contents
for d in *; do
    echo "1. [\`$d\`](#$d)"
    for sd in $d/.*; do
        bn=$(basename $sd)
        if [ "$bn" != "." ] && [ "$bn" != ".." ]; then
            echo "\t1. [\`$bn\`](#$bn)"
        fi
    done
done
echo
~/.dotfiles/scripts/toc
```

1. [`README.md`](#README.md)
1. [`bash`](#bash)
	1. [`.bash_aliases`](#.bash_aliases)
	1. [`.bashrc`](#.bashrc)
	1. [`.inputrc`](#.inputrc)
1. [`cl_zsh`](#cl_zsh)
	1. [`.zshrc`](#.zshrc)
1. [`firefox`](#firefox)
1. [`journals`](#journals)
1. [`jupyter`](#jupyter)
1. [`noted`](#noted)
	1. [`.notedconfig`](#.notedconfig)
1. [`nvim`](#nvim)
	1. [`.config`](#.config)
1. [`scripts`](#scripts)
	1. [`.usr_scripts`](#.usr_scripts)
1. [`tmux`](#tmux)
	1. [`.tmux.conf`](#.tmux.conf)
1. [`wezterm`](#wezterm)
	1. [`.wezterm.lua`](#.wezterm.lua)
1. [`zsh`](#zsh)
	1. [`.zshrc`](#.zshrc)


## `README.md`
This file.

## `bash/`
This directory gets symlinked to the home folder

> [TODO] add symlink command

### `.bash_aliases`
Bash aliases:
```
### misc #######################################################################
c           clear
q           duck duck go
            scripts/duck
qq          chat gpt
            scripts/gippity
pst         paste from clipboard
datedir     create a directory with today's date + a README.md inside
            scripts/datedir
zk          open zettelkasten in nvim
tm          tmux startup / reattach
            scripts/tmux_startup
ta          tmux quick reattach
nnb         create a new jupyter notebook with JupyText
            scripts/create_nb.sh

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
> [DEPRICATED] using bash instead

## `firefox/`
Firefox Cuscomization
1. visit about:support 
1. find Application Basics > Profile Directory
1. symlink the ./chrome folder to the Profile Directory
    > [TODO] add symlink command
1. copy an image to the file /usr/share/backgrounds/wallpaper to be used as the newtab wallpaper

> [TODO] I also have a firefox setting that shrinks the UI. I forget what it is; find and document

### `chrome/userContent.css`
CSS for setting blank tab background image

## `journals/vim.md`
vim stuff to work on

> [TODO] Depricate - this should be removed in favor of the zettelkasten

## `jupyter/`

### `create_nb.sh`
Use JupyText to create a new jupyter notebook based on a template

### `templates/`
Notebook templates

    temp.py

## `noted/.notedconfig`
> [DEPRICATED] in favor of zettelkasten.

> [TODO] uninstall noted

## `nvim/.config/`
This directory gets symlinked to the home folder

> [TODO] add symlink command

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

### `cht.sh`
> [TODO] document

### `datedir`
> [TODO] document

### `duck`
> [TODO] document

### `emoji`
> [TODO] document

### `gippity`
> [TODO] document

### `install_neovim.sh`
> [TODO] document

### `kb_firmware.service`
> [TODO] document

### `kb_firmware.sh`
> [TODO] document

### `moon`
> [TODO] document

### `now_playing`
> [TODO] document

### `obs_status`
> [TODO] document

### `tmux_startup`
> [TODO] document

### `toc`
> [TODO] document

### `urlencode`
> [TODO] document

### `weather`
> [TODO] document

### `.usr_scripts/.ja_scripts`
> [TODO] document

### `st/credits`
> [TODO] document


## `tmux/`
This directory gets symlinked to the home folder

> [TODO] add symlink command

### `.tmux.conf`
> [TODO] document

### `tmux_status_right`
> [TODO] document


## `wezterm/`
This directory gets symlinked to the home folder

> [TODO] add symlink command

### `.wezterm.lua`
> [TODO] document


## `zsh/.zshrc`
> [DEPRICATED] in favor of bash
