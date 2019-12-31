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
EOBUNDLES

antigen apply
