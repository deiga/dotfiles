#!/bin/sh

# Dont source `~/.asdf/asdf.sh`
PATH="$PATH:$BREW_PREFIX/opt/asdf/bin"
source "$BREW_PREFIX/opt/asdf/lib/asdf.sh" # just load the asdf wrapper function

# Hook direnv into your shell.
eval "$(asdf exec direnv hook zsh)"

asdf-use() {
  plugin=$1
  shift
  version=$1
  shift
  command=$@

  (
    asdf shell $plugin $version
    eval $command
  )
}

direnv() { asdf exec direnv "$@"; }

if type fasd >/dev/null; then
  eval "$(fasd --init auto)"
fi
