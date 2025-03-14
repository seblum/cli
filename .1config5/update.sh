#!/bin/bash

# Enable alias expansion in non-interactive shell
shopt -s expand_aliases

# Define the git alias
alias 1config5='/usr/bin/git --git-dir=$HOME/.1config5-git/ --work-tree=$HOME'

# Get list of all tracked files in the repo except update.sh itself
repo_files=$(1config5 ls-tree -r main --name-only | grep -v ".update.sh")

# Process each file
for file in $repo_files; do
  # Check if the file exists locally
  if [ -f "$HOME/$file" ]; then
    echo "Updating & merging $file..."
    
    # Ensure the subdirectories in /tmp are created
    temp_file_dir="/tmp/repo_$(dirname "$file")"
    mkdir -p "$temp_file_dir"
    
    # Create temp file with repo version in the correct directory
    1config5 show HEAD:$file > "$temp_file_dir/$(basename $file)"
    
    # Backup existing file
    cp $HOME/$file $HOME/$file.backup
    
    # Append repo content to existing file
    echo "" >> $HOME/$file
    echo "# Added from dotfiles repo on $(date)" >> $HOME/$file
    cat "$temp_file_dir/$(basename $file)" >> $HOME/$file
    
    # Clean up
    rm "$temp_file_dir/$(basename $file)"
    
    # Mark as assume-unchanged
    1config5 update-index --assume-unchanged $file
  else
    # File doesn't exist locally, safe to checkout
    echo "Updating & merging $file..."
    1config5 checkout HEAD -- $file
  fi
done

echo "All files processed!"
