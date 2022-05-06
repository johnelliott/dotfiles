#!/usr/bin/env bash

name='steamroller'

# Set computer name (as done via System Preferences → Sharing)
sudo scutil --set ComputerName $name
sudo scutil --set HostName $name
sudo scutil --set LocalHostName $name
sudo defaults write /Library/Preferences/SystemConfiguration/com.apple.smb.server NetBIOSName -string $name
