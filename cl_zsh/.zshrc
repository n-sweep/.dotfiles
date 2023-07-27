#!/bin/bash

# source normal zshrc
source ~/.dotfiles/zsh/.zshrc

# Vault address export
export VAULT_ADDR=https://vault.it.cl-aws.net:8200

# QA scratch folder
export PREDICTOR_SCRATCH=$HOME/.closedloop/work/predictor_scratch

# ClosedLoop aliases
alias ci='code-insiders'
alias lab="jupyter lab --notebook-dir=~/work"
alias jup="jupyter lab --notebook-dir=~/work --no-browser > /dev/null 2>&1 &"
alias aws_creds="python ~/work/closedloop-api-python/closedloop/api_private/scripts/set_aws_prod_s3_credentials.py"
alias vault_login="vault login -method=ldap username=noah.shreve"
alias tm='cd ~/work && tmux'
alias ta='tmux a'
alias tb=timeblock.py # gcal api script
alias nnb=create_nb.py
alias aliases="python ~/work/closedloop-ds/closedloop/ds/alias_cli.py"
alias vpn="openvpn3 session-start --config /home/n/work/.closedloop/CL_VPN.conf > /dev/null 2>&1"

# CL init: mount encrypted drive & connect to vpn
cl_init() {
    sudo cryptsetup luksOpen /dev/nvme0n1p3 work
    sudo mount /dev/mapper/work /home/n/work
    vpn
}

# Allow Jupyter to open the browser automatically on launch
BROWSER='/mnt/c/Program Files/BraveSoftware/Brave-Browser/Application/brave.exe'

# Copy from file:  File > Clipboard
cpf () { win32yank.exe -o > "$1" }
# Paste to file:   Clipboard > File (WSL)
psf () { cat "$1" | win32yank.exe -i }

# correct work env
conda deactivate
conda activate cl
