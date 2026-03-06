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

# install ctags
git clone https://github.com/universal-ctags/ctags.git
cd ctags
./autogen.sh
./configure --prefix=$SCRIPT_DIR/ctags_build
make
make install
ln -nsf $SCRIPT_DIR/ctags_build/bin/ctags ~/ctags

#install slang-server and symlink
#git clone https://github.com/hudson-trading/slang-server.git
#cd slang-server
#git submodule update --init --recursive
#cmake -B build -DCMAKE_BUILD_TYPE=Release
#cmake --build build -j --target slang_server
#ln -nsf $SCRIPT_DIR/slang_server ~/slang_server
