#!/bin/zsh

source /usr/local/share/antigen/antigen.zsh

antigen bundles <<EOBUNDLES

  tmux
  tmuxinator
  dash
  terraform
  thefuck

  sorin-ionescu/prezto modules/ssh

  zsh-users/zsh-completions
  zsh-users/zsh-autosuggestions
  zsh-users/zsh-syntax-highlighting
  https://gist.github.com/junegunn/8b572b8d4b5eddd8b85e5f4d40f17236 # git-fzf
  b4b4r07/enhancd
EOBUNDLES

antigen apply
