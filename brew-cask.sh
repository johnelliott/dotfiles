#!/usr/bin/env bash

# Make sure homebrew is installed first
if [[ ! "$(type -P brew)" ]]; then
	echo "Installing Homebrew"
	ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

brew install --cask macvim rectangle vlc firefox
