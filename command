#!/bin/bash

# Clone dotfiles repo and apply configurations
echo "Cloning and setting up dotfiles..."
git clone --bare git@github.com:seblum/cfg.git $HOME/.cfg

# Call the external script for additional setup
echo "Running cfg setup script..."
bash "$HOME/.cfg/setup.sh"

# Checkout the dotfiles
cfg checkout

# Disable untracked files from showing up in git status
cfg config --local status.showUntrackedFiles no
