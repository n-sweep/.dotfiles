#!/bin/bash

apt-get update
apt-get install -y stow git ripgrep zsh software-properties-common

chsh -s $(which zsh)
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

apt-add-repository ppa:neovim-ppa/unstable
apt-get update
apt-get install -y neovim

git clone --depth 1 https://github.com/wbthomason/packer.nvim\
    ~/.local/share/nvim/site/pack/packer/start/packer.nvim
