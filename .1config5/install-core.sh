#!/bin/bash

set -e  # Exit immediately if a command exits with a non-zero status

echo "Installing Homebrew..."
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# Ensure brew is available in PATH
if ! command -v brew &> /dev/null; then
    echo "Homebrew installation failed. Exiting."
    exit 1
fi

brew install wget 
brew install gh
brew install just 
