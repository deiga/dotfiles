#!/usr/bin/env bash

set -e
set -x
set -u

echo "Running 'xcode-select --install'"
xcode-select --install || true

echo "Sleeping for 30sec"
sleep 30s

echo "Cloning into ~/dotfiles"
git clone https://github.com/deiga/dotfiles.git ~/dotfiles

cd ~/dotfiles

echo "Ask for assistive access"
osascript -e 'tell application "System Events" to click (every button whose value of attribute "AXDescription" is "add desktop") of group 1 of process "Dock"' || true
osascript -e 'tell app "System Preferences"' -e 'activate' -e 'set current pane to pane "com.apple.preference.security"' -e 'end tell'

echo "Sleeping for 30sec"
sleep 30s

echo "Running rake install"
rake install
