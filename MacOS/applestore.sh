defaults write com.apple.dock autohide -bool true
killall dock 2>&1
osascript -e "tell application \"System Preferences\"" -e "set the current pane to pane id \"com.apple.preference.keyboard\"" -e "reveal anchor \"keyboardTab_ModifierKeys\" of pane id \"com.apple.preference.keyboard\"" -e "activate"  -e "end tell"

