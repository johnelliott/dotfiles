#!/usr/bin/env bash

# Make sure homebrew is installed first
if [[ ! "$(type -P brew)" ]]; then
	echo "Installing Homebrew"
	ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

# Install homebrew cask apps
brew cask install atom 2> /dev/null
brew cask install google-chrome 2> /dev/null
brew cask install macvim 2> /dev/null
brew cask install postgres 2> /dev/null
brew cask install slack 2> /dev/null
brew cask install spectacle 2> /dev/null
brew cask install vlc 2> /dev/null
