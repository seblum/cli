#!/bin/bash

# Define the cfg function for installing and managing dotfiles
if ! grep -q "cfg() {" "$HOME/.bashrc"; then
    echo "Adding cfg function to .bashrc"
    cat <<EOL >> "$HOME/.bashrc"

# cfg function for dotfiles management
1k5-setup() {
    echo "Updating dotfiles repository..."
    # Pull latest changes from the main branch
    /usr/bin/git --git-dir="$HOME/.cfg/" --work-tree="$HOME" pull origin main

    # Check if install.sh exists and run it
    if [ -f "$HOME/.cfg/install.sh" ]; then
        echo "Running install.sh from repository..."
        bash "$HOME/.cfg/install.sh"
    else
        echo "install.sh not found in repository."
    fi
}
EOL
    echo "cfg function added to .bashrc"
fi

# Add alias for 'cfg' command to .bashrc if not already present
if ! grep -q "alias cfg=" "$HOME/.bashrc"; then
    echo "Adding cfg alias to .bashrc"
    echo "alias cfg='/usr/bin/git --git-dir=\$HOME/.cfg/ --work-tree=\$HOME'" >> "$HOME/.bashrc"
fi

# Reload .bashrc to apply changes
echo "Reloading .bashrc..."
source "$HOME/.bashrc"
