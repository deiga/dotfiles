#!/bin/sh
# local ASDF_DIR=$(brew --prefix asdf)
# In order to bypass asdf shims. We *only* add the `ASDF_DIR/bin`
# directory to PATH, since we still want to use `asdf` but not its shims.
# [[ $PATH == *"asdf/bin"* ]] || export PATH="$PATH:ASDF_DIR/bin"
# . $ASDF_DIR/lib/asdf.sh
. $(brew --prefix asdf)/asdf.sh
# [[ $PATH == *"direnv"* ]] || local DIRENV_PATH=$(dirname $(asdf which direnv)) && export PATH="$DIRENV_PATH:$PATH"

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
