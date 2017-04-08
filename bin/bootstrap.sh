#!/usr/bin/env bash

set -e
set -x
set -u

echo "Running 'xcode-select --install'"
xcode-select --install || true
sleep 1

echo "Sleeping for 30sec"
sleep 1m

echo "Cloning into ~/dotfiles"
git clone https://github.com/deiga/dotfiles.git ~/dotfiles

cd ~/dotfiles

osascript -e 'tell application "System Events" to click (every button whose value of attribute "AXDescription" is "add desktop") of group 1 of process "Dock"' # Ask for assistive access
osascript -e 'tell app "System Preferences"' -e 'activate' -e 'set current pane to pane "com.apple.preference.security"' -e 'end tell'
osascript -e 'tell app "Finder" to display dialog "Please accept assistive access for iTerm"'

echo "Sleeping for 30sec"
sleep 30

echo "Running rake install"
rake install
