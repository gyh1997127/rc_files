#!/bin/bash

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
echo "SCRIPT_DIR=$SCRIPT_DIR"

# make $HOME/.config directory if it doens't exist
mkdir -p ~/.config/

# tmux
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
ln -nsf $SCRIPT_DIR/tmux/tmux.conf ~/.tmux.conf

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

# install binaries
LOCAL_BIN_DIR=$HOME/.local/bin
mkdir -p $LOCAL_BIN_DIR

# install ctags
git clone https://github.com/universal-ctags/ctags.git
cd ctags
./autogen.sh
./configure --prefix=$SCRIPT_DIR/ctags_build
make
make install
ln -nsf $SCRIPT_DIR/ctags_build/bin/ctags $LOCAL_BIN_DIR/tags

# install neovim
git clone https://github.com/neovim/neovim
cd neovim
rm -r build
make CMAKE_EXTRA_FLAGS="-DCMAKE_INSTALL_PREFIX=$PWD/neovim_build"
make install
ln -nsf $PWD/neovim_build/bin/nvim $LOCAL_BIN_DIR/nvim
