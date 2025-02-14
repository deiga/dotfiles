#!/bin/sh

direnv() { asdf exec direnv "$@"; }

if type zoxide >/dev/null; then
  eval "$(zoxide init zsh --cmd j)"
fi

if [ -d "$BREW_PREFIX/share/google-cloud-sdk" ]; then
  source "$BREW_PREFIX/share/google-cloud-sdk/path.zsh.inc"
  source "$BREW_PREFIX/share/google-cloud-sdk/completion.zsh.inc"
fi
