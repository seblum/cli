# PATH=/Users/sebastian.blum/Documents/dataplatform/
# [ -f ~/.fzf.bash ] && source ~/.fzf.bash

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

alias cfg='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'
