# Environment Setup

## Install NeoVim

```bash
# Install Packages
apt-get install git
apt-get install ripgrep
```

```bash
# Install zsh
apt-get install zsh
# Make default shell
chsh -s $(which zsh)
# Install Oh My Zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
apt-get install fonts-powerline
```

```bash
# Install NeoVim
sudo apt-get install software-properties-common
sudo apt-add-repository ppa:neovim-ppa/unstable
sudo apt-get update
sudo apt-get install neovim
```

```bash
# Install Packer plugin manager
git clone --depth 1 https://github.com/wbthomason/packer.nvim\
 ~/.local/share/nvim/site/pack/packer/start/packer.nvim
# Run :PackerInstall in neovim
```

