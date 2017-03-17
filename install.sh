#/!/bin/bash

function removeOldFiles() {
  for file in ~/.{aliases,bash_profile,bash_prompt,bashrc,curlrc,exports,gitconfig,gitignore,hushlogin,inputrc,path,tmux.conf,wgetrc,zshrc,.npmrc,}; do
    rm "$file" >/dev/null 2>&1
  done
}

function copyNewFiles() {
  for file in ./.{aliases,bash_profile,bash_prompt,bashrc,curlrc,exports,gitconfig,gitignore,hushlogin,inputrc,path,tmux.conf,wgetrc,zshrc,.npmrc,}; do
    cp "$file" ~/ 2>&1
  done
}

function doIt() {
  removeOldFiles
  copyNewFiles
  source ~/.bash_profile
}

cd "$(dirname "${BASH_SOURCE}")" || exit

read -p "Would you like to install .vimrc and vim-plug? (y/n) " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
  cp .vimrc ~/.vimrc
  cp .gvimrc ~/.gvimrc
  curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
fi

if [[ $(uname) == 'Darwin' ]]; then

  read -p "Would you like to set up xcode CLI tools? (y/n) " -n 1 -r
  echo
  if [[ $REPLY =~ ^[Yy]$ ]]; then
    xcode-select -install
  fi

  # Install Node Version Manager
  read -p "Would you like to install node version manager? (y/n) " -n 1 -r
  echo
  if [[ $REPLY =~ ^[Yy]$ ]]; then
    curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.33.0/install.sh | bash
  fi

  # GUI apps via Homebrew
  read -p "Would you like to set up GUI Homebrew apps? (y/n) " -n 1 -r
  echo
  if [[ $REPLY =~ ^[Yy]$ ]]; then
    ./brew-cask.sh
  fi

  # CLI apps via Homebrew
  read -p "Would you like to set up Homebrew apps? (y/n) " -n 1 -r
  echo
  if [[ $REPLY =~ ^[Yy]$ ]]; then
    ./brew.sh
  fi

  if [ "$1" == "--force" ] || [ "$1" == "-f" ]; then
    doIt
  else
    read -p "This may overwrite existing files in your home directory. Are you sure? (y/n) " -n 1 -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
      doIt
    fi
  fi

  read -p "Would you like to set up OS X preferences? (y/n) " -n 1 -r
  echo
  if [[ $REPLY =~ ^[Yy]$ ]]; then
    ./macOS.sh
  fi

fi

