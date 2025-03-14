#!/bin/bash

set -e  # Exit immediately if a command exits with a non-zero status

echo "Installing core utilities..."
bash .1config5/install-core.sh

# Prompt user for optional installations
read -p "Do you want to install cloud tools? (y/n) " install_cloud
read -p "Do you want to install infrastructure tools? (y/n) " install_infra
read -p "Do you want to install VSCode? (y/n) " install_vscode

# Install cloud tools if requested
if [[ "$install_cloud" == "y" ]]; then
    bash .1config5/install-cloud.sh
fi

# Install infrastructure tools if requested
if [[ "$install_infra" == "y" ]]; then
    bash .1config5/install-infrastructure.sh
fi

# Install VSCode if requested
if [[ "$install_vscode" == "y" ]]; then
    bash .1config5/install-vscode.sh
fi

