#/!/bin/bash

cd "$(dirname "${BASH_SOURCE}")" || exit

function removeOldFiles() {
  for file in ~/.{aliases,bash_profile,bash_prompt,bashrc,curlrc,exports,gitconfig,gitignore,hushlogin,inputrc,path,tmux.conf,wgetrc,zshrc,}; do
    rm "$file" >/dev/null 2>&1
  done
}

function copyNewFiles() {
  for file in ./.{aliases,bash_profile,bash_prompt,bashrc,curlrc,exports,gitconfig,gitignore,hushlogin,inputrc,path,tmux.conf,wgetrc,zshrc,}; do
    cp "$file" ~/ 2>&1
  done
}

function doIt() {
  removeOldFiles
  copyNewFiles
  source ~/.bash_profile
}

if [ "$1" == "--force" ] || [ "$1" == "-f" ]; then
  doIt
else
  read -p "This may overwrite existing files in your home directory. Are you sure? (y/n) " -n 1 -r
  echo
  if [[ $REPLY =~ ^[Yy]$ ]]; then
    doIt
  fi
fi

# Install Homebrew on OS X
if [[ $(uname) == 'Darwin' ]]; then
  read -p "Would you like to set up Homebrew? (y/n) " -n 1 -r
  echo
  if [[ $REPLY =~ ^[Yy]$ ]]; then
    ./brew.sh
  fi

  read -p "Would you like to set up GUI APPS via brew cask? (y/n) " -n 1 -r
  echo
  if [[ $REPLY =~ ^[Yy]$ ]]; then
    ./brew-cask.sh
  fi

  # Install node version manager
  read -p "Would you like to install node version manager? (y/n) " -n 1 -r
  echo
  if [[ $REPLY =~ ^[Yy]$ ]]; then
    PROFILE=~/.bash_profile curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.33.0/install.sh | bash
  fi

  # Install npm packages
  if which npm > /dev/null; then
    read -p "Would you like to install npm packages? (y/n) " -n 1 -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
      ./npm.sh
    fi
  fi

  read -p "Would you like to install .vimrc and vim-plug? (y/n) " -n 1 -r
  echo
  if [[ $REPLY =~ ^[Yy]$ ]]; then
    cp .vimrc ~/.vimrc
    curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
      https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  fi

  read -p "Would you like to set up OS X preferences? (y/n) " -n 1 -r
  echo
  if [[ $REPLY =~ ^[Yy]$ ]]; then
    ./macOS.sh
  fi

fi
