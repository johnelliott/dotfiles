#!/usr/bin/env bash

# Make sure homebrew is installed first
if [[ ! "$(type -P brew)" ]]; then
	echo "Installing Homebrew"
	ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

brew install cask macvim spectacle vlc

#brew cask install atom
#brew cask install cyberduck
#brew cask install google-chrome
#brew cask install google-cloud-sdk
#brew cask install postgres
#brew cask install slack

#brew cask install qlcolorcode
#brew cask install qlstephen
#brew cask install qlmarkdown
#brew cask install quicklook-json
#brew cask install qlimagesize
#brew cask install webpquicklook
#brew cask install suspicious-package
#brew cask install qlvideo
