#!/usr/bin/env bash

set -e
set -x
set -u

echo "Running 'xcode-select --install'"
check=$( (xcode-\select --install || true) 2>&1)
while [[ $check == *"install requested"* ]];
do
  echo "Waiting for installation to finish..."
  sleep 5
  check=$( (xcode-\select --install || true) 2>&1)
done

echo "Cloning into ~/dotfiles"
git clone https://github.com/deiga/dotfiles.git ~/dotfiles || true

if [[ $? != 0 ]]; then
  cd ~/dotfiles
  git pull
fi

cd ~/dotfiles

echo "Ask for assistive access"
osascript -e 'tell application "System Events" to click at {0,0}' || true

if [[ $? != 0 ]]; then
  echo "Waiting for assistive access"
  osascript -e 'tell app "System Preferences"' -e 'activate' -e 'set current pane to pane "com.apple.preference.security"' -e 'end tell'
  sleep 30
fi


echo "Running rake install"
rake install
