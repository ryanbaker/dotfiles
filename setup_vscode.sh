#!/bin/sh
cp settings.json ~/.config/Code/User/
cp keybindings.json ~/.config/Code/User/
cat extensions-list.txt | xargs -L 1 code --install-extension

