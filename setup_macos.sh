#!/bin/bash

# These are some of the less obvious MacOS tweaks

# Config
SCREENSHOTS_DIR=~/screenshots

# Set screenshots directory
mkdir -p $SCREENSHOTS_DIR
defaults write com.apple.screencapture location $SCREENSHOTS_DIR

# Turn off the annoying accent menu when long pressing some letters
defaults write -g ApplePressAndHoldEnabled -bool false

# Remove all icons from desktop
defaults write com.apple.finder CreateDesktop -bool false

# Don't hide Library directory in Finder
chflags nohidden ~/Library/
