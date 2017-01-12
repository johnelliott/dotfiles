#!/usr/bin/env bash

# Set computer name (as done via System Preferences → Sharing)
sudo scutil --set ComputerName "diffie"
sudo scutil --set HostName "diffie"
sudo scutil --set LocalHostName "diffie"
sudo defaults write /Library/Preferences/SystemConfiguration/com.apple.smb.server NetBIOSName -string "diffie"

