# Environment Setup


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
# Install zsh plugins
git clone https://github.com/zsh-users/zsh-autosuggestions.git $ZSH_CUSTOM/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $ZSH_CUSTOM/plugins/zsh-syntax-highlighting
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install
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

```bash
# Install GitHub CLI
sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-key C99B11DEB97541F0
sudo apt-add-repository https://cli.github.com/packages
sudo apt-get update
sudo apt-get install gh
```

```bash
# Install jupyter_ascending
pip install jupyter_ascending && \
jupyter nbextension install jupyter_ascending --sys-prefix --py && \
jupyter nbextension enable jupyter_ascending --sys-prefix --py && \
jupyter serverextension enable jupyter_ascending --sys-prefix --py

# Make a new paired file
python -m jupyter_ascending.scripts.make_pair --base file_name

# Convert existing notebook to py file
jupytext --to py:percent nb_file.sync.ipynb
# Sync notebook w/ python file
python -m jupyter_ascending.requests.sync --filename py_file.sync.py
```

```bash
# Jupyter notebook themes
pip install jupyterthemes
pip install --upgrade jupyterthemes

jt -t gruvboxd -f ubuntu -nfs 11 -T -N -kl

```
