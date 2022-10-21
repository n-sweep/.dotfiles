#!/bin/bash

# source normal zshrc
source ~/.dotfiles/zsh/.zshrc

# Vault address export
export VAULT_ADDR=https://vault.it.cl-aws.net:8200

# QA scratch folder
export PREDICTOR_SCRATCH=$HOME/.closedloop/predictor_scratch

# ClosedLoop aliases
alias ci='code-insiders'
alias lab="jupyter lab --notebook-dir=~/work"
alias jup="jupyter lab --notebook-dir=~/work --no-browser > /dev/null 2>&1 &"
alias aws_creds="python ~/work/closedloop-api-python/closedloop/api_private/scripts/set_aws_prod_s3_credentials.py"
alias vault_login="vault login -method=ldap username=noah.shreve"

# Allow Jupyter to open the browser automatically on launch 
BROWSER='/mnt/c/Program Files/BraveSoftware/Brave-Browser/Application/brave.exe'

# Copy from file:  File > Clipboard
cpf () { win32yank.exe -o > "$1" }
# Paste to file:   Clipboard > File (WSL)
psf () { cat "$1" | win32yank.exe -i }

# correct work env
conda deactivate
conda activate cl

# gcal api script
alias tb=timeblock.py

alias tm='cd ~/work && tmux'
