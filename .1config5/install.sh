#!/bin/bash

set -e  # Exit immediately if a command exits with a non-zero status

echo "Installing Homebrew..."
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# Ensure brew is available in PATH
if ! command -v brew &> /dev/null; then
    echo "Homebrew installation failed. Exiting."
    exit 1
fi

echo "Installing core utilities..."
brew install wget just gh

# Prompt user for optional installations
read -p "Do you want to install cloud tools? (y/n) " install_cloud
read -p "Do you want to install infrastructure tools? (y/n) " install_infra

# Install cloud tools if requested
if [[ "$install_cloud" == "y" ]]; then
    echo "Installing cloud tools..."
    brew install --cask google-cloud-sdk
    brew install awscli
fi

# Install infrastructure tools if requested
if [[ "$install_infra" == "y" ]]; then
    echo "Installing infrastructure tools..."
    brew install docker
    brew tap hashicorp/tap
    brew install hashicorp/tap/terraform
    brew update && brew upgrade hashicorp/tap/terraform
    brew install kubectl
fi

# Verify installation
echo "Verifying installations..."
echo "$(terraform --version || echo 'Terraform not installed')"
echo "$(docker --version || echo 'Docker not installed')"
kubectl version --client || echo "kubectl not installed correctly"

# Install VSCode extensions
echo "Installing VSCode extensions..."
if command -v code &> /dev/null; then
    if [ -f "$HOME/.cfg/vscode-extensions.list" ]; then
        cat $HOME/.cfg/vscode-extensions.list | xargs -L 1 code --install-extension
    else
        echo "VSCode extensions list not found in repository. Skipping installation."
    fi
else
    echo "VSCode not found. Skipping extensions installation."
fi

echo "Installation complete! You can now use the 'just' command to manage your environment."
