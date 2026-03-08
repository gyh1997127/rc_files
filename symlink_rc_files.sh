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

# neovim
ln -nsf $SCRIPT_DIR/nvim ~/.config/nvim

# alacritty
ln -nsf $SCRIPT_DIR/alacritty ~/.config/

# zshrc
ln -nsf $SCRIPT_DIR/zshrc ~/.zshrc

# git
ln -nsf $SCRIPT_DIR/Git/gitconfig ~/.gitconfig

# generate .slang
ln -nsf $SCRIPT_DIR/generate_slang_config.py ~/generate_slang_config.py

#install cargo
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y --no-modify-path

# install binaries
LOCAL_BIN_DIR=$HOME/.local/bin
mkdir -p $LOCAL_BIN_DIR

# install treesitter
cargo install tree-sitter-cli --root ~/.local

# install ctags
cd "$SCRIPT_DIR"
echo "Building ctags"
git clone https://github.com/universal-ctags/ctags.git
cd ctags
./autogen.sh
./configure --prefix=$SCRIPT_DIR/ctags_build
make
make install
ln -nsf $SCRIPT_DIR/ctags_build/bin/ctags $LOCAL_BIN_DIR/tags

# install neovim
cd "$SCRIPT_DIR"
git clone https://github.com/neovim/neovim
cd neovim
make CMAKE_EXTRA_FLAGS="-DCMAKE_INSTALL_PREFIX=$PWD/neovim_build"
make install
ln -nsf $PWD/neovim_build/bin/nvim $LOCAL_BIN_DIR/nvim

# install tree-sitter-cli
cd "$SCRIPT_DIR"
TREE_SITTER_VERSION="v0.26.6"

UNAME_S=$(uname -s)
if [[ "$UNAME_S" == "Darwin" ]]; then
  OS_NAME="macos"
elif [[ "$UNAME_S" == "Linux" ]]; then
  OS_NAME="linux"
else
  echo "Unsupported OS: $UNAME_S"
  exit 1
fi

UNAME_M=$(uname -m)
if [[ "$UNAME_M" == "x86_64" ]]; then
  ARCH_NAME="x64"
elif [[ "$UNAME_M" == "arm64" || "$UNAME_M" == "aarch64" ]]; then
  ARCH_NAME="arm64"
else
  echo "Unsupported architecture: $UNAME_M"
  exit 1
fi

ASSET_NAME="tree-sitter-${OS_NAME}-${ARCH_NAME}.gz"
TS_DIR="$SCRIPT_DIR/tree-sitter-cli"
mkdir -p "$TS_DIR"
cd "$TS_DIR"

echo "Downloading tree-sitter-cli $TREE_SITTER_VERSION for $OS_NAME-$ARCH_NAME..."
curl -LO "https://github.com/tree-sitter/tree-sitter/releases/download/${TREE_SITTER_VERSION}/${ASSET_NAME}"
gunzip -c "$ASSET_NAME" > tree-sitter
chmod +x tree-sitter
ln -nsf "$TS_DIR/tree-sitter" "$LOCAL_BIN_DIR/tree-sitter"

# install slang-server
cd "$SCRIPT_DIR"
SLANG_SERVER_VERSION="v0.2.2"

UNAME_S=$(uname -s)
if [[ "$UNAME_S" == "Darwin" ]]; then
  SLANG_ASSET_NAME="slang-server-macos.tar.gz"
elif [[ "$UNAME_S" == "Linux" ]]; then
  UNAME_M=$(uname -m)
  if [[ "$UNAME_M" == "x86_64" ]]; then
    SLANG_ASSET_NAME="slang-server-linux-x64-clang.tar.gz"
  else
    echo "Unsupported architecture for slang-server on Linux: $UNAME_M"
    exit 1
  fi
else
  echo "Unsupported OS for slang-server: $UNAME_S"
  exit 1
fi

SLANG_DIR="$SCRIPT_DIR/slang-server"
mkdir -p "$SLANG_DIR"
cd "$SLANG_DIR"

echo "Downloading slang-server $SLANG_SERVER_VERSION for $UNAME_S..."
curl -LO "https://github.com/hudson-trading/slang-server/releases/download/${SLANG_SERVER_VERSION}/${SLANG_ASSET_NAME}"
tar -xzf "$SLANG_ASSET_NAME"
chmod +x slang-server
ln -nsf "$SLANG_DIR/slang-server" "$LOCAL_BIN_DIR/slang-server"
