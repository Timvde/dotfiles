#!/bin/bash

PWD=$(pwd)

echo "Linking files"

ln -s "${PWD}/.bash_aliases" ~/.bash_aliases
ln -s "${PWD}/.tmux.conf" ~/.tmux.conf
ln -s "${PWD}/.vim" ~/.vim
ln -s "${PWD}/.vimrc" ~/.vimrc
ln -s "${PWD}/.zshrc" ~/.zshrc
ln -s "${PWD}/.gitignore_global" ~/.gitignore_global
ln -s "${PWD}/.gitconfig" ~/.gitconfig

echo "Linking done"
