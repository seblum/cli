# Clone dotfiles repo and apply configurations
echo "Cloning and setting up dotfiles..."
git clone --bare git@github.com:seblum/cli.git $HOME/.cfg
alias cfg='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'

# Force checkout only the update script
# might need a cfg reset --hard 
cfg checkout -- .1config5/update.sh

# Make it executable
chmod +x $HOME/.1config5/update.sh

# Run the update script to handle the remaining files
echo "Running update script to resolve conflicts..."
bash $HOME/.1config5/update.sh

source "$HOME/.bashrc"

echo "Dotfiles setup complete!"