# Alias for git commands with bare repository
alias cfg='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'

# Define custom cfg function
cfg() {
    if [ "$1" == "install" ]; then
        echo "Updating dotfiles repository..."
        # Pull latest changes from the main branch
        cfg pull origin main

        # Check if an install.sh script exists and run it
        if [ -f "$HOME/.cfg/install.sh" ]; then
            echo "Running install.sh from repository..."
            bash "$HOME/.cfg/install.sh"
        else
            echo "install.sh not found in repository. Exiting."
            return 1
        fi
    else
        # Default behavior: pass through other git commands to the dotfiles repo
        /usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME "$@"
    fi
}

# Append the alias and function to the .bashrc if not already present
if ! grep -q "alias cfg=" "$HOME/.bashrc"; then
    echo "Adding cfg alias to .bashrc"
    echo "alias cfg='/usr/bin/git --git-dir=\$HOME/.cfg/ --work-tree=\$HOME'" >> "$HOME/.bashrc"
fi

if ! grep -q "cfg() {" "$HOME/.bashrc"; then
    echo "Adding cfg function to .bashrc"
    cat <<EOL >> "$HOME/.bashrc"

# cfg function for dotfiles management
cfg() {
    if [ "\$1" == "install" ]; then
        echo "Updating dotfiles repository..."
        # Pull latest changes from the main branch
        cfg pull origin main

        # Check if install.sh exists and run it
        if [ -f "\$HOME/.cfg/install.sh" ]; then
            echo "Running install.sh from repository..."
            bash "\$HOME/.cfg/install.sh"
        else
            echo "install.sh not found in repository. Exiting."
            return 1
        fi
    else
        # Default behavior: pass through other git commands to the dotfiles repo
        /usr/bin/git --git-dir=\$HOME/.cfg/ --work-tree=\$HOME "\$@"
    fi
}
EOL
    echo "cfg function added to .bashrc"
fi

# Reload .bashrc to apply changes
echo "Reloading .bashrc..."
source "$HOME/.bashrc"
