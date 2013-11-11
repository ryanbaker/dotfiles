#!/bin/sh

# Set normal keyboard repeat functionality
defaults write -g ApplePressAndHoldEnabled -bool false

# Configure the HOME/END buttons
mkdir -p ~/Library/KeyBindings/
cp DefaultKeyBinding.dict ~/Library/KeyBindings/
