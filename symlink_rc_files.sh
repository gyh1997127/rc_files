#!/bin/bash

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
echo "SCRIPT_DIR=$SCRIPT_DIR"

# make $HOME/.config directory if it doens't exist
mkdir -p ~/.config/

# tmux
ln -nsf $SCRIPT_DIR/tmux ~/.config/

# vimrc
mkdir -p ~/.vim
curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
ln -nsf $SCRIPT_DIR/vimrc ~/.vim/

# alacritty
ln -nsf $SCRIPT_DIR/alacritty ~/.config/

# zshrc
ln -nsf $SCRIPT_DIR/zshrc ~/.zshrc

# git
ln -nsf $SCRIPT_DIR/Git/gitconfig ~/.gitconfig
