
# Install VSCode extensions
echo "Installing VSCode extensions..."
if command -v code &> /dev/null; then
    if [ -f "$HOME/.1config5/vscode-extensions.list" ]; then
        cat $HOME/.1config5/vscode-extensions.list | xargs -L 1 code --install-extension
    else
        echo "VSCode extensions list not found in repository. Skipping installation."
    fi
else
    echo "VSCode not found. Skipping extensions installation."
fi

echo "Installation complete! You can now use the 'just' command to manage your environment."
