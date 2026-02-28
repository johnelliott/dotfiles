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
#brew bundle check || brew bundle install

# Write OS-specific git credential helper (~/.gitconfig includes this file)
if [ "$os" = "Darwin" ]; then
  printf '[credential]\n  helper = osxkeychain\n' > ~/.gitconfig-os
elif [ "$os" = "Linux" ]; then
  printf '[credential]\n  helper = /usr/libexec/git-core/git-credential-libsecret\n' > ~/.gitconfig-os
fi

# Symlink configs into ~ using GNU Stow
# Each directory here mirrors the home directory structure.
# For example, git/.gitconfig becomes ~/.gitconfig.

# Shell
stow -t ~ readline

# Git
stow -t ~ git

# CLI tool configs
stow -t ~ curl wget ripgrep npm psql

# Editors
stow -t ~ tmux vim

mkdir -p ~/.config/nvim
stow -t ~/.config/nvim nvim

# Terminal
mkdir -p ~/.config/ghostty
stow -t ~/.config/ghostty ghostty

# Prompt
stow -t ~/.config starship
