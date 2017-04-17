dotfiles
=======

Requirements:
  * Ruby
  * rake

Contains:
    
  * Ruby (rbenv)
  * Python
  * ZSH
  * Vim
  * Powerline

See [Brewfile](config/Brewfile) for all installed apps

Usage:

    git clone git@github.com:deiga/dotfiles.git
    cd dotfiles
    git submodules init
    git submodules update
    rake install

Manual labour:

  * Add Assistive Access for following programs:
    * Alfred 3.app
    * Amethyst.app
    * iTerm.app
    * Script Editor.app
    * Karabiner_AXNotifier.app
  * Activate Alfred 3 Powerpack
  * Login to Dropbox
  * Login to Evernote
  * Login to Google Chrome
  * Login to SourceTree
