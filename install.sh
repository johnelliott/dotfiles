#!/bin/bash

# Explode if something exits with non-zero status
set -e

os="$(uname)"
case "$os" in
Darwin) echo "This is macOS" ;;
Linux) echo "This is Linux" ;;
*) echo "Unknown OS" ;;
esac

# Homebrew installs
# https://docs.brew.sh/Brew-Bundle-and-Brewfile
brew bundle check || brew bundle install

# use gnu-stow to install
stow -t ~ tmux vim readline curl git ripgrep wget

mkdir -p ~/.config/nvim
stow -t ~/.config/nvim nvim

mkdir -p ~/.config/ghostty
stow -t ~/.config/ghostty ghostty

# Starship config
mkdir -p ~/.config/starship
stow -t ~/.config/starship starship
