# dotfiles

See [Brewfile](config/Brewfile) for all installed apps

## Install

### Scripted

    curl --fail --show-error --silent --location https://raw.githubusercontent.com/deiga/dotfiles/master/bin/bootstrap.sh | bash

### Manually

    git clone git@github.com:deiga/dotfiles.git
    cd dotfiles
    rake install

## Usage

- `rake install` - To install dependencies and insert files to their correct location
- `rake update` - To update dependencies on your system

Both have sub-tasks which can be run on their own to limit their scope of effect

## Manual setup needs

- Add Assistive Access for following programs:
  - Alfred 4.app
  - Amethyst.app
  - iTerm.app
  - Karabiner-Elements.app
- Activate Alfred 4 Powerpack
- Login to Dropbox
- Login to Evernote
- Login to Google Chrome
- Login to SourceTree
