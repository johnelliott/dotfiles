read -p "Would you like to wipe the doc contents (y/n) " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
  defaults write com.apple.dock persistent-apps -array
  sudo killall Dock > /dev/null 2>&1
fi
echo "You may need to restart"
