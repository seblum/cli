#!/bin/bash

set -e  # Exit immediately if a command exits with a non-zero status

echo "Installing cloud tools..."
brew install --cask google-cloud-sdk
brew install awscli

echo "Installation complete!"
echo "You can now use the cloudcli tooling."