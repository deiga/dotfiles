#!/usr/bin/env bash

set -e
set -x
set -u

if [ ! $(xcodebuild -version) ]; 
then
  echo "Running 'xcode-select --install'"
  check=$( (xcode-\select --install || true) 2>&1)
  while [[ $check == *"install requested"* ]];
  do
    echo "Waiting for installation to finish..."
    sleep 5
    check=$( (xcode-\select --install || true) 2>&1)
  done
fi

DOTFILES_REPO=~/dotfiles

echo "Cloning into ~/dotfiles"
if [ ! -d $DOTFILES_REPO/.git ]
then
    git clone https://github.com/deiga/dotfiles.git $DOTFILES_REPO
else
    cd $DOTFILES_REPO
    git pull
fi

cd $DOTFILES_REPO

set +e
echo "Ask for assistive access"
osascript -e 'tell application "System Events" to click at {0,0}'
set -e

if [[ $? != 0 ]]; then
  echo "Waiting for assistive access"
  osascript -e 'tell app "System Preferences"' -e 'activate' -e 'set current pane to pane "com.apple.preference.security"' -e 'end tell'
  sleep 30
fi

echo "Updating rake"
sudo gem update rake

echo "Running rake install"
rake install
