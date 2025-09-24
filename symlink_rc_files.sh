#!/bin/bash

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
echo "SCRIPT_DIR=$SCRIPT_DIR"

# make $HOME/.config directory if it doens't exist
mkdir -p ~/.config/

# tmux
ln -s $SCRIPT_DIR/tmux ~/.config/

# vimrc
mkdir -p ~/.vim
ln -s $SCRIPT_DIR/vimrc ~/.vim/

# alacritty
ln -s $SCRIPT_DIR/alacritty ~/.config/

# zshrc
ln -s $SCRIPT_DIR/zshrc ~/.zshrc
