#!/bin/sh
cd
rm -rf .vim .gitconfig .vimrc .bash_profile .profile .bash_rc .bashrc .zshrc .zshenv
ln -s dotfiles/.vim
ln -s dotfiles/.vimrc
ln -s dotfiles/.gitconfig
ln -s dotfiles/.bash_profile
ln -s dotfiles/.profile
ln -s dotfiles/.bashrc
ln -s dotfiles/.zshrc
ln -s dotfiles/.zshenv
ln -s dotfiles/.imwheelrc

ln -s ~/dotfiles/touchpad-scroll.desktop ~/.config/autostart/
ln -s ~/dotfiles/imwheel.sh.desktop ~/.config/autostart/
sudo ln -s ~/dotfiles/99-mouse-imwheel.rules /etc/udev/rules.d/
ln -s ~/dotfiles/vscode_keybindings.json ~/.config/Code/User/keybindings.json
ln -s ~/dotfiles/vscode_settings.json ~/.config/Code/User/settings.json
# KWin (KF5) won't load a script whose directory is a symlink, so link its contents instead
mkdir -p ~/.local/share/kwin/scripts/restorewindowscreens
ln -s ~/dotfiles/kwin/restorewindowscreens/metadata.json ~/dotfiles/kwin/restorewindowscreens/contents ~/.local/share/kwin/scripts/restorewindowscreens/
kwriteconfig5 --file kwinrc --group Plugins --key restorewindowscreensEnabled true
