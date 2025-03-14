#!/bin/bash

# Define the git alias 
alias cfg='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'

# Get list of all tracked files in the repo except update.sh itself
repo_files=$(cfg ls-files | grep -v "update.sh")

# Process each file
for file in $repo_files; do
  # Check if the file exists locally
  if [ -f "$HOME/$file" ]; then
    echo "Merging $file..."
    
    # Create temp file with repo version
    cfg show HEAD:$file > /tmp/repo_$file
    
    # Backup existing file
    cp $HOME/$file $HOME/$file.backup
    
    # Append repo content to existing file
    echo "" >> $HOME/$file
    echo "# Added from dotfiles repo on $(date)" >> $HOME/$file
    cat /tmp/repo_$file >> $HOME/$file
    
    # Clean up
    rm /tmp/repo_$file
    
    # Mark as assume-unchanged
    cfg update-index --assume-unchanged $file
  else
    # File doesn't exist locally, safe to checkout
    echo "Checking out $file..."
    cfg checkout -- $file
  fi
done

echo "All files processed!"