#!/bin/sh

# https://asdf-vm.com/guide/getting-started.html#_3-install-asdf
source "$BREW_PREFIX/opt/asdf/libexec/asdf.sh"

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

asdf-each() {
  local plugin=$1
  shift
  local command=$@

  for version in $(asdf list $plugin); do
    echo "Running '$command' for $plugin version $version"
    asdf-use $plugin $version $command
  done
}

direnv() { asdf exec direnv "$@"; }

if type zoxide >/dev/null; then
  eval "$(zoxide init zsh --cmd j)"
fi

if [ -d "/usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/" ]; then
  source "/usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/path.zsh.inc"
  source "/usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/completion.zsh.inc"
fi
