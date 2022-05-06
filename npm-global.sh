#!/usr/bin/env bash
	read -p "Would you like to install NVM? (y/n) " -n 1 -r
	echo
	if [[ $REPLY =~ ^[Yy]$ ]]; then
      curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.32.1/install.sh | bash
	fi

# Install npm modules

npm install -g eslint
npm install -g standard
npm install -g nodemon
npm install -g budo
npm install -g browserify
