#!/usr/bin/env bash

set -e
set -x
set -u

echo "Running 'xcode-select --install'"
check=$( (xcode-\select --install || true) 2>&1)
echo $check
str="xcode-select: note: install requested for command line developer tools"
while [[ "$check" == "$str" ]];
do
  echo "Waiting for installation to finish..."
  sleep 5
done

echo "Cloning into ~/dotfiles"
git clone https://github.com/deiga/dotfiles.git ~/dotfiles || true

cd ~/dotfiles

echo "Ask for assistive access"
osascript -e 'tell application "System Events" to click (every button whose value of attribute "AXDescription" is "add desktop") of group 1 of process "Dock"' || true

if [[ $? == 0 ]]; then
  echo "Waiting for assistive access"
  osascript -e 'tell app "System Preferences"' -e 'activate' -e 'set current pane to pane "com.apple.preference.security"' -e 'end tell'
  sleep 30
fi


echo "Running rake install"
#rake install
