#!/usr/bin/env bash

# Install command-line tools using Homebrew.

# Ask for the administrator password
sudo -v

# Keep-alive: update existing `sudo` time stamp until the script has finished.
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

# Make sure homebrew is installed first
if [[ ! "$(type -P brew)" ]]; then
	echo "Installing Homebrew"
	ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

# Upgrade any already-installed formulae.
brew doctor
brew update

# Install GNU core utilities (those that come with OS X are outdated).
# Don’t forget to add `$(brew --prefix coreutils)/libexec/gnubin` to `$PATH`.
brew install coreutils
sudo ln -s /usr/local/bin/gsha256sum /usr/local/bin/sha256sum

# Install some other useful utilities like `sponge`.
brew install moreutils
# Install GNU `find`, `locate`, `updatedb`, and `xargs`, `g`-prefixed.
brew install findutils
# Install GNU `sed`, overwriting the built-in `sed`.
brew install gnu-sed --with-default-names
# Install Bash 4.
# Note: don’t forget to add `/usr/local/bin/bash` to `/etc/shells` before
# running `chsh`.
brew install bash
brew install zsh
brew tap homebrew/versions
brew install bash-completion2
brew install wget --with-iri
brew install vim --with-override-system-vi
brew install homebrew/dupes/grep
brew install homebrew/dupes/openssh
brew install homebrew/dupes/screen
brew install git
brew install git-lfs
brew install hub # https://github.com/github/hub
brew install tree
brew install ack
brew install the_silver_searcher
brew install fzf
brew install tmux
brew install nmap
brew install certbot
brew install imagemagick --with-webp
brew install ssh-copy-id
brew install webkit2png
brew install mysql
brew install redis
brew install postgresql
brew install awscli

# Remove outdated versions from the cellar.
brew cleanup
