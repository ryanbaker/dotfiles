#NOTE, this is obsolete. Settings files are saved in dotfiles and symlinked
#with link.sh... except for the extension
#!/bin/sh
cp settings.json ~/.config/Code/User/
cp keybindings.json ~/.config/Code/User/
cat extensions-list.txt | xargs -L 1 code --install-extension

