#!/usr/bin/env bash

# ~/.osx — https://mths.be/osx

# Ask for the administrator password upfront
sudo -v

# Keep-alive: update existing `sudo` time stamp until `.osx` has finished
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

# General UI/UX
# power plug chime
defaults write com.apple.PowerChime ChimeOnAllHardware -bool true

# Set computer name (as done via System Preferences → Sharing)
#sudo scutil --set ComputerName "diffie"
#sudo scutil --set HostName "diffie"
#sudo scutil --set LocalHostName "diffie"
#sudo defaults write /Library/Preferences/SystemConfiguration/com.apple.smb.server NetBIOSName -string "diffie"

# Learn about defaults:
# https://github.com/kevinSuttle/macOS-Defaults/blob/master/REFERENCE.md
# Touch bar Fn key: pressing function key down shows control strip and not F1, F2 etc.
defaults write com.apple.touchbar.agent PresentationModeFnModes -dict \
  app fullControlStrip \
  appWithControlStrip fullControlStrip

# Customize Control Strip in Sierra
defaults write com.apple.controlstrip MiniCustomized -array \
  com.apple.system.media-play-pause \
  com.apple.system.brightness \
  com.apple.system.volume \
  com.apple.system.mute

defaults write com.apple.controlstrip FullCustomized -array \
  com.apple.system.sleep \
  com.apple.system.mission-control \
  com.apple.system.group.media \
  com.apple.system.group.volume \
  com.apple.system.group.keyboard-brightness \
  com.apple.system.group.brightness

# Keyboard speeds
# 15 InitialKeyRepeat and 2 KeyRepeat are max settings of the Settings.app sliders
# could go something like 1 and 10, but that seems crazy fast
defaults write NSGlobalDomain KeyRepeat -int 2
defaults write NSGlobalDomain InitialKeyRepeat -int 14
# map caps to control on macbook pro 13,2
defaults -currentHost write -g com.apple.keyboard.modifiermapping.1452-631-0 -dict HIDKeyboardModifierMappingDst 30064771296 HIDKeyboardModifierMappingSrc 30064771129
# WASD code keybaord 87-key
defaults -currentHost write -g com.apple.keyboard.modifiermapping.1241-617-0 -dict HIDKeyboardModifierMappingDst 3ya0064771296 HIDKeyboardModifierMappingSrc 30064771129

# Trackpad
defaults write NSGlobalDomain com.apple.trackpad.scaling -float 1 # speed
defaults write com.apple.AppleMultitouchTrackpad ActuationStrength -int 0 # silent clicking
defaults write com.apple.AppleMultitouchTrackpad FirstClickThreshold -int 0
defaults write com.apple.AppleMultitouchTrackpad SecondClickThreshold -int 0
defaults write com.apple.AppleMultitouchTrackpad TrackpadThreeFingerDrag -bool true
defaults write com.apple.AppleBluetoothMultitouch.trackpad TrackpadThreeFingerDrag -bool true
defaults write com.apple.dock showLaunchpadGestureEnabled -bool false
defaults write com.apple.dock showAppExposeGestureEnabled -bool true
# Bluetooth Trackpad
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -bool true
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadThreeFingerDrag -bool true

# Dark mode and reduce transparency
defaults write .GlobalPreferences AppleInterfaceStyle -string "Dark"
defaults write com.apple.universalaccess reduceTransparency -int 1

# Prefer tabs when opening documents
defaults write NSGlobalDomain AppleWindowTabbingMode -string "always" # always fullscreen manual

# Set highlight color to hi-viz green
defaults write NSGlobalDomain AppleHighlightColor -string "0.840000 1.000000 0.000000"

# Use scroll gesture with the Ctrl (^) modifier key to zoom
defaults write com.apple.universalaccess closeViewScrollWheelToggle -int 1
defaults write com.apple.universalaccess closeViewPanningMode -int 0

# Expand save panel by default
defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode -bool true
defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode2 -bool true

# Expand print panel by default
defaults write NSGlobalDomain PMPrintingExpandedStateForPrint -bool true
defaults write NSGlobalDomain PMPrintingExpandedStateForPrint2 -bool true

# Save to disk (not to iCloud) by default
defaults write NSGlobalDomain NSDocumentSaveNewDocumentsToCloud -bool false

# No delay for spring-loaded drags?
defaults write NSGlobalDomain com.apple.springing.enabled -bool true
defaults write NSGlobalDomain com.apple.springing.delay -float 0 # No delay in seconds

# Set Help Viewer windows to non-floating mode
defaults write com.apple.helpviewer DevMode -bool true

# Disable press-and-hold for keys in favor of key repeat
defaults write NSGlobalDomain ApplePressAndHoldEnabled -bool false

# Finder
# Finder: allow quitting via ⌘ + Q; doing so will also hide desktop icons
#defaults write com.apple.finder QuitMenuItem -bool true

# Set up desktop icon view
/usr/libexec/PlistBuddy -c "Set :DesktopViewSettings:IconViewSettings:arrangeBy kind" ~/Library/Preferences/com.apple.finder.plist
#/usr/libexec/PlistBuddy -c "Set :DesktopViewSettings:IconViewSettings:gridSpacing 100" ~/Library/Preferences/com.apple.finder.plist
/usr/libexec/PlistBuddy -c "Set :DesktopViewSettings:IconViewSettings:labelOnBottom 0" ~/Library/Preferences/com.apple.finder.plist
/usr/libexec/PlistBuddy -c "Set :DesktopViewSettings:IconViewSettings:showItemInfo 0" ~/Library/Preferences/com.apple.finder.plist
/usr/libexec/PlistBuddy -c "Set :DesktopViewSettings:IconViewSettings:iconSize 16" ~/Library/Preferences/com.apple.finder.plist

# Finder: show all filename extensions
defaults write NSGlobalDomain AppleShowAllExtensions -bool true
# Disable the warning when changing a file extension
defaults write com.apple.finder FXEnableExtensionChangeWarning -int 0

# Finder: allow text selection in Quick Look
defaults write com.apple.finder QLEnableTextSelection -bool true

# Display full POSIX path as Finder window title
#defaults write com.apple.finder _FXShowPosixPathInTitle -bool true

# When performing a search, search the current folder by default
#defaults write com.apple.finder FXDefaultSearchScope -string "SCcf"

# Enable AirDrop over Ethernet and on unsupported Macs running Lion
#defaults write com.apple.NetworkBrowser BrowseAllInterfaces -bool true

# Show the ~/Library folder
chflags nohidden ~/Library

# save screenshots to /Desktop/Screenshots
mkdir -p "${HOME}/Desktop/Screenshots"
defaults write com.apple.screencapture location -string "${HOME}/Desktop/Screenshots"

# Allow hitting the Backspace key to go to the previous page in history
defaults write com.apple.Safari "com.apple.Safari.ContentPageGroupIdentifier.WebKit2BackspaceKeyNavigationEnabled" -bool true
defaults write com.apple.safari Command1Through9SwitchesTabs -int 1
defaults write com.apple.safari IncludeDevelopMenu -int 1
defaults write com.apple.safari SendDoNotTrackHTTPHeader -int 1
defaults write com.apple.safari ShowFullURLInSmartSearchField -int 1
defaults write com.apple.safari ShowOverlayStatusBar -int 1
defaults write com.apple.safari "com.apple.Safari.ContentPageGroupIdentifier.WebKit2DeveloperExtrasEnabled" -int 1
defaults write com.apple.safari "com.apple.Safari.ContentPageGroupIdentifier.WebKit2TabsToLinks" -int 1
#defaults write com.apple.safari NewWindowBehavior -int 4
defaults write com.apple.safari TabCreationPolicy -int 2
#defaults write com.apple.safari WebKitDeveloperExtrasEnabledPreferenceKey -int 1
#defaults write com.apple.safari WebKitTabToLinksPreferenceKey -int 1

# Dock
# Remove the auto-hiding Dock delay
defaults write com.apple.dock autohide -bool true
defaults write com.apple.dock autohide-delay -float 0
# Remove the animation when hiding/showing the Dock
defaults write com.apple.dock autohide-time-modifier -float 0
# Set the icon size of Dock items to 64 pixels
defaults write com.apple.dock tilesize -int 64

# stop iTunes
sudo chmod 000 /Applications/iTunes.app

# Kill affected applications
for app in "TouchBarAgent" "Activity Monitor" "Address Book" "Calendar" "Contacts" "cfprefsd" \
	"Dock" "Finder" "Google Chrome" "Google Chrome Canary" "Mail" "Messages" \
	"Opera" "Safari" "SizeUp" "Spectacle" "SystemUIServer" "Terminal" \
	"Transmission" "Twitter" "iCal"; do
	killall "${app}" > /dev/null 2>&1
done
echo "Done. Note that some of these changes require a logout/restart to take effect."

