#!/bin/sh
cd
rm -rf .vim .gitconfig .vimrc .bash_profile .profile .bash_rc .bashrc
ln -s dotfiles/.vim
ln -s dotfiles/.vimrc
ln -s dotfiles/.gitconfig
ln -s dotfiles/.bash_profile
ln -s dotfiles/.profile
ln -s dotfiles/.bashrc

