#!/usr/bin/env bash
	read -p "Would you like to install NVM? (y/n) " -n 1 -r
	echo
	if [[ $REPLY =~ ^[Yy]$ ]]; then
	  wget -qO- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash
	fi

# Install npm modules

npm install -g eslint
npm install -g standard
npm install -g nodemon
npm install -g budo
npm install -g browserify
