#!/usr/bin/env bash

# Make sure homebrew is installed first
if [[ ! "$(type -P brew)" ]]; then
	echo "Installing Homebrew"
	ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

for app in atom cyberduck firefox google-chrome google-cloud-sdk macvim postgres slack spectacle vlc
do
  brew cask install $app
done
