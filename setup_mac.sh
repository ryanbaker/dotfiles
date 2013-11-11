#!/bin/sh

# Set normal keyboard repeat functionality
defaults write -g ApplePressAndHoldEnabled -bool false

# Configure the HOME/END buttons
mkdir -p ~/Library/KeyBindings/
cp DefaultKeyBinding.dict ~/Library/KeyBindings/

# Copy iTerm2 config
cp com.googlecode.iterm2.plist ~/Library/Preferences/
