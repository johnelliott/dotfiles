#!/bin/bash

# Explode if something exits with non-zero status
set -e

os="$(uname)"
case "$os" in
  Darwin) echo "This is macOS";;
  Linux) echo "This is Linux";;
  *) echo "Unknown OS";;
esac

# Homebrew installs
# https://docs.brew.sh/Brew-Bundle-and-Brewfile
brew bundle check || brew bundle install
