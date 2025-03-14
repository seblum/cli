# PATH=/Users/sebastian.blum/Documents/dataplatform/
# [ -f ~/.fzf.bash ] && source ~/.fzf.bash

1config5-setup() {
    echo "Updating dotfiles repository..."
    # Pull latest changes from the main branch
    /usr/bin/git --git-dir="$HOME/.1config5-git/" --work-tree="$HOME" pull origin main

    # Check if setup.sh exists and run it
    if [ -f "$HOME/.1config5/setup.sh" ]; then
        echo "Running setup.sh from repository..."
        bash "$HOME/.1config5/setup.sh"
    else
        echo ".1config5/setup.sh not found in repository."
    fi
}

1config5-update() {
    # Enable alias expansion in non-interactive shell
    shopt -s expand_aliases

    # Define the git alias
    alias 1config5='/usr/bin/git --git-dir=$HOME/.1config5-git/ --work-tree=$HOME'

    # Clone dotfiles repo and apply configurations
    1config5 pull origin main

    # Force checkout only the update script
    # might need a 1config5 reset --hard 
    1config5 checkout -- .1config5/update.sh

    # Make it executable
    chmod +x $HOME/.1config5/update.sh

    # Run the update script to handle the remaining files
    echo "Running update script to resolve conflicts..."
    bash $HOME/.1config5/update.sh

    source "$HOME/.bashrc"

    echo "Update complete!"
}

alias 1config5='/usr/bin/git --git-dir=$HOME/.1config5-git/ --work-tree=$HOME'
