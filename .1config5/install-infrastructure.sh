#!/bin/bash

set -e  # Exit immediately if a command exits with a non-zero status

echo "Installing infrastructure tools..."
brew install docker
brew tap hashicorp/tap
brew install hashicorp/tap/terraform
brew update && brew upgrade hashicorp/tap/terraform
brew install kubectl

echo "Verifying installations..."
echo "$(terraform --version || echo 'Terraform not installed')"
echo "$(docker --version || echo 'Docker not installed')"
kubectl version --client || echo "kubectl not installed correctly"

echo "Installation complete!"
echo "You can now use the infrastructure tooling."
