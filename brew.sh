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

# Install some other useful utilities like `sponge`.
# Install Bash 4.
# Note: don’t forget to add `/usr/local/bin/bash` to `/etc/shells` before
# running `chsh`.
brew install bash
brew tap homebrew/versions

# Install GNU core utilities (those that come with OS X are outdated).
# Don’t forget to add `$(brew --prefix coreutils)/libexec/gnubin` to `$PATH`.
brew install coreutils
sudo ln -s /usr/local/bin/gsha256sum /usr/local/bin/sha256sum

brew install ack \
  ansible \
  bash \
  bash-completion@2 \
  bat \
  csvkit \
  exiftool \
  ext2fuse \
  ext4fuse \
  fzf \
  git \
  git-lfs \
  htop \
  btop \
  jq \
  fd \
  moreutils \
  netcat \
  nmap \
  openssh \
  openssl \
  pup \
  reattach-to-user-namespace \
  rsync \
  sqlite \
  ssh-copy-id \
  ripgrep \
  tmux \
  tree \
  #google-cloud-sdk \
  #transmission \
  #stern \
  #speedtest-cli \
  #postgresql \
  #nginx \
  #kubernetes-cli \
  #kubectx \
  #hub \
  #grep \
  #graphicsmagick \
  #goaccess \
  #ffmpeg \
  #certbot \
  #awscli \
  yt-dlp

brew tap filosottile/musl-cross
brew install findutils # Install GNU `find`, `locate`, `updatedb`, and `xargs`, `g`-prefixed.
brew install gnu-sed --with-default-names # Install GNU `sed`, overwriting the built-in `sed`.
brew install vim --with-override-system-vi
brew install wget --with-iri
brew install --HEAD universal-ctags/universal-ctags/universal-ctags

# Remove outdated versions from the cellar.
brew cleanup
