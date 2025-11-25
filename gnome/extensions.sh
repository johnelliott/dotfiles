#!/bin/bash

# gnome-shell-extension-manager should be installed by bazzite images

# install tools for scripting extension installs
brew install pipx gum

# install extension downloader/installer
pipx install gnome-extensions-cli --system-site-packages

# Pause to assure user is ready to accept confirmations, ty omakub
gum confirm "To install Gnome extensions, you need to accept some confirmations. Ready?"

# system extensions that may already be installed
gnome-extensions enable caffeine@patapon.info
gnome-extensions enable gsconnect@andyholmes.github.io
gnome-extensions enable hotedge@jonathan.jdoda.ca

# disable existing extensions
gnome-extensions disable blur-my-shell@aunetx
gnome-extensions disable burn-my-windows@schneegans.github.com
gnome-extensions disable compiz-alike-magic-lamp-effect@hermes83.github.com
gnome-extensions disable compiz-windows-effect@hermes83.github.com
gnome-extensions disable desktop-cube@schneegans.github.com

# user extensions
gext install space-bar@luchrioh
gext install display-brightness-ddcutil@themightydeity.github.com
gext install just-perfection-desktop@just-perfection
gext install tiling-assistant@leleat-on-github
gext install Vitals@CoreCoding.com

# Compile user extension gsettings schemas in order to be able to set them
glib-compile-schemas ~/.local/share/gnome-shell/extensions/space-bar\@luchrioh/schemas/
glib-compile-schemas ~/.local/share/gnome-shell/extensions/display-brightness-ddcutil@themightydeity.github.com/schemas/
glib-compile-schemas ~/.local/share/gnome-shell/extensions/just-perfection-desktop\@just-perfection/schemas/
glib-compile-schemas ~/.local/share/gnome-shell/extensions/tiling-assistant@leleat-on-github/schemas/
glib-compile-schemas ~/.local/share/gnome-shell/extensions/Vitals@CoreCoding.com/schemas/

