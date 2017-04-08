#!/usr/bin/env bash

set -e
set -x
set -u

echo "Cloning into ~/dotfiles"
git --version

cd ~/dotfiles

osascript -e 'tell application "System Events" to click (every button whose value of attribute "AXDescription" is "add desktop") of group 1 of process "Dock"' # Ask for assistive access
osascript -e 'tell app "Finder" to display dialog "Please accept assistive access for iTerm"'

echo "Sleeping for 1min"
sleep 1m

echo "Running rake install"
#rake install
