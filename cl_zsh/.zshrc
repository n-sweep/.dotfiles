#!/bin/bash

# source normal zshrc
source ~/.dotfiles/zsh/.zshrc

# Vault address export
export VAULT_ADDR=https://vault.it.cl-aws.net:8200

# QA scratch folder
export PREDICTOR_SCRATCH=~n/.closedloop/predictor_scratch

# ClosedLoop aliases
alias ci='code-insiders'
alias lab="jupyter lab --notebook-dir=~/work"
alias jup="jupyter lab --notebook-dir=~/work --no-browser > /dev/null 2>&1 &"
alias aws_creds="python ~/work/closedloop-api-python/closedloop/api_private/scripts/set_aws_prod_s3_credentials.py"

# Allow Jupyter to open the browser automatically on launch 
BROWSER='/mnt/c/Program Files/BraveSoftware/Brave-Browser/Application/brave.exe'

# Clipboard > File (WSL)
cpf () { cat "$1" | win32yank.exe -i }
# File > Clipboard
psf () { win32yank.exe -o > "$1" }

# correct work env
conda deactivate
conda activate cl

# gcal api script
alias tb=timeblock.py

alias tm='cd ~/work && tmux'
