# Clone dotfiles repo and apply configurations
echo "Cloning and setting up dotfiles..."
git clone --bare git@github.com:seblum/cli.git $HOME/.cfg
alias cfg='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'

# Force checkout only the update script
cfg checkout -f -- .update.sh

# Make it executable
chmod +x $HOME/.update.sh

# Run the update script to handle the remaining files
echo "Running update script to resolve conflicts..."
$HOME/update.sh

echo "Dotfiles setup complete!"