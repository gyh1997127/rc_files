#!/bin/bash

# Exit on error
set -e

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
LOCAL_BIN_DIR=$HOME/.local/bin
mkdir -p "$LOCAL_BIN_DIR"
mkdir -p "$HOME/.config"

UNAME_S=$(uname -s)
UNAME_M=$(uname -m)
echo "Running on OS: $UNAME_S, ARCH: $UNAME_M"

# --- Helper Functions ---

# Create a symlink, removing existing files/links if necessary
safe_ln() {
    local src="$1"
    local dest="$2"
    echo "Linking $src -> $dest"
    ln -nsf "$src" "$dest"
}

# Clone a repository or pull if it already exists
clone_or_update() {
    local repo_url="$1"
    local target_dir="$2"
    if [ -d "$target_dir" ]; then
        echo "Updating $target_dir..."
        cd "$target_dir" && git pull
    else
        echo "Cloning $repo_url..."
        git clone "$repo_url" "$target_dir"
    fi
}

# Download and extract a GitHub release asset
download_gh_release() {
    local repo="$1"
    local version="$2"
    local asset="$3"
    local target_dir="$4"
    local bin_name="$5"
    local strip_components="${6:-0}"

    if [ -f "$LOCAL_BIN_DIR/$bin_name" ]; then
        echo "$bin_name already installed, skipping..."
        return
    fi

    mkdir -p "$target_dir"
    cd "$target_dir"
    echo "Downloading $bin_name $version..."
    curl -LO "https://github.com/$repo/releases/download/$version/$asset"
    
    if [[ "$asset" == *.tar.gz ]]; then
        tar -xzf "$asset" --strip-components="$strip_components"
    elif [[ "$asset" == *.zip ]]; then
        unzip -o "$asset"
    fi
    
    chmod +x "$bin_name"
    safe_ln "$target_dir/$bin_name" "$LOCAL_BIN_DIR/$bin_name"
}

# --- Core Symlinks ---

echo "Setting up symlinks..."
safe_ln "$SCRIPT_DIR/tmux/tmux.conf" "$HOME/.tmux.conf"
safe_ln "$SCRIPT_DIR/nvim" "$HOME/.config/nvim"
safe_ln "$SCRIPT_DIR/alacritty" "$HOME/.config/alacritty"
safe_ln "$SCRIPT_DIR/zshrc" "$HOME/.zshrc"
safe_ln "$SCRIPT_DIR/Git/gitconfig" "$HOME/.gitconfig"
safe_ln "$SCRIPT_DIR/generate_slang_config.py" "$HOME/generate_slang_config.py"

# vimrc setup
mkdir -p "$HOME/.vim"
if [ ! -f "$HOME/.vim/autoload/plug.vim" ]; then
    curl -fLo "$HOME/.vim/autoload/plug.vim" --create-dirs \
        https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
fi
safe_ln "$SCRIPT_DIR/vimrc" "$HOME/.vim/vimrc"

# --- Tool Installations ---

# Tmux Plugin Manager
if [ ! -d "$HOME/.tmux/plugins/tpm" ]; then
    git clone https://github.com/tmux-plugins/tpm "$HOME/.tmux/plugins/tpm"
fi

# Rust/Cargo
if ! command -v cargo &> /dev/null; then
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y --no-modify-path
    source "$HOME/.cargo/env"
fi

# Tree-sitter CLI
if ! command -v tree-sitter &> /dev/null; then
    cargo install tree-sitter-cli --root ~/.local
fi

# Universal Ctags
if [ ! -f "$LOCAL_BIN_DIR/tags" ]; then
    CTAGS_DIR="$SCRIPT_DIR/ctags"
    clone_or_update "https://github.com/universal-ctags/ctags.git" "$CTAGS_DIR"
    cd "$CTAGS_DIR"
    ./autogen.sh
    ./configure --prefix="$SCRIPT_DIR/ctags_build"
    make -j$(nproc 2>/dev/null || echo 4)
    make install
    safe_ln "$SCRIPT_DIR/ctags_build/bin/ctags" "$LOCAL_BIN_DIR/tags"
fi

# Neovim (build from source)
if [ ! -f "$LOCAL_BIN_DIR/nvim" ]; then
    NVIM_DIR="$SCRIPT_DIR/neovim"
    clone_or_update "https://github.com/neovim/neovim" "$NVIM_DIR"
    cd "$NVIM_DIR"
    make CMAKE_EXTRA_FLAGS="-DCMAKE_INSTALL_PREFIX=$PWD/neovim_build" -j$(nproc 2>/dev/null || echo 4)
    make install
    safe_ln "$PWD/neovim_build/bin/nvim" "$LOCAL_BIN_DIR/nvim"
fi

# Slang Server
SLANG_VERSION="v0.2.2"
if [[ "$UNAME_S" == "Darwin" ]]; then
    SLANG_ASSET="slang-server-macos.tar.gz"
elif [[ "$UNAME_S" == "Linux" && "$UNAME_M" == "x86_64" ]]; then
    SLANG_ASSET="slang-server-linux-x64-clang.tar.gz"
fi

if [ -n "$SLANG_ASSET" ]; then
    download_gh_release "hudson-trading/slang-server" "$SLANG_VERSION" "$SLANG_ASSET" "$SCRIPT_DIR/slang-server" "slang-server" 0
fi

# Ripgrep
RG_VERSION="15.1.0"
if [[ "$UNAME_S" == "Darwin" ]]; then
    RG_ASSET="ripgrep-${RG_VERSION}-$( [[ "$UNAME_M" == "arm64" ]] && echo "aarch64" || echo "x86_64" )-apple-darwin.tar.gz"
elif [[ "$UNAME_S" == "Linux" ]]; then
    if [[ "$UNAME_M" == "x86_64" ]]; then
        RG_ASSET="ripgrep-${RG_VERSION}-x86_64-unknown-linux-musl.tar.gz"
    elif [[ "$UNAME_M" == "aarch64" || "$UNAME_M" == "arm64" ]]; then
        RG_ASSET="ripgrep-${RG_VERSION}-aarch64-unknown-linux-gnu.tar.gz"
    fi
fi

if [ -n "$RG_ASSET" ]; then
    download_gh_release "BurntSushi/ripgrep" "$RG_VERSION" "$RG_ASSET" "$SCRIPT_DIR/ripgrep" "rg" 1
fi

echo "All tasks completed successfully!"
