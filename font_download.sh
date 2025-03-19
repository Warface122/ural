#!/bin/bash

# Step 1: Create font directory and download JetBrains Mono Nerd Font
mkdir -p ~/.local/share/fonts
cd ~/.local/share/fonts
curl -fLo "JetBrainsMono.zip" https://github.com/ryanoasis/nerd-fonts/releases/download/v3.3.0/FiraCode.zip
unzip JetBrainsMono.zip
rm JetBrainsMono.zip

# Step 2: Refresh font cache for xterm terminal
fc-cache -fv

# Step 3: Check if ~/.Xresources exists, create if not, and preserve other settings
if [ ! -f ~/.Xresources ]; then
    echo "File ~/.Xresources not found. Creating it..."
    touch ~/.Xresources
fi

# Add settings if they are not already present
if ! grep -q "XTerm*faceName: JetBrainsMono Nerd Font" ~/.Xresources; then
    echo -e "\nXTerm*faceName: JetBrainsMono Nerd Font" >> ~/.Xresources
    echo "Added font face name to ~/.Xresources."
fi

if ! grep -q "XTerm*faceSize: 12" ~/.Xresources; then
    echo "XTerm*faceSize: 12" >> ~/.Xresources
    echo "Added font face size to ~/.Xresources."
fi

# Step 4: Apply the new configuration
xrdb ~/.Xresources

# Step 5: Print instruction to reset terminal
echo "Please close and reopen your terminal to apply the changes."
