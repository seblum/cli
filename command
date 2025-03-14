#!/bin/bash

# Clone dotfiles repo and apply configurations
echo "Cloning and setting up dotfiles..."
git clone --bare git@github.com:seblum/cli.git $HOME/.cfg
alias cfg='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'
cfg checkout

# Call the external script for additional setup
echo "Running cfg setup script..."
bash "$HOME/.setup.sh"

# Checkout the dotfiles
cfg checkout

# Disable untracked files from showing up in git status
cfg config --local status.showUntrackedFiles no
