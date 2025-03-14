# PATH=/Users/sebastian.blum/Documents/dataplatform/
# [ -f ~/.fzf.bash ] && source ~/.fzf.bash

# cfg function for dotfiles management
1k5-setup() {
    echo "Updating dotfiles repository..."
    # Pull latest changes from the main branch
    /usr/bin/git --git-dir="$HOME/.cfg/" --work-tree="$HOME" pull origin main

    # Check if install.sh exists and run it
    if [ -f "$HOME/.cfg/.1config5/install.sh" ]; then
        echo "Running install.sh from repository..."
        bash "$HOME/.cfg/.1config5/install.sh"
    else
        echo ".1config5/install.sh not found in repository."
    fi
}

1k5-update() {
    # Enable alias expansion in non-interactive shell
    shopt -s expand_aliases

    # Define the git alias
    alias cfg='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'

    # Clone dotfiles repo and apply configurations
    cfg pull origin main

    # Force checkout only the update script
    # might need a cfg reset --hard 
    cfg checkout -- .1config5/update.sh

    # Make it executable
    chmod +x $HOME/.1config5/update.sh

    # Run the update script to handle the remaining files
    echo "Running update script to resolve conflicts..."
    bash $HOME/.1config5/update.sh

    source "$HOME/.bashrc"

    echo "Update complete!"
}

alias cfg='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'
