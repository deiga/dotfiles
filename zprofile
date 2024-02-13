# vim syn=zsh
#echo 'zprofile' $0 # Debug
# zmodload zsh/zprof
# Locale settings
if [[ -z "$LANG" ]]; then
  export LANG="en_GB.UTF-8"
  export LANGUAGE="en_GB.UTF-8"
fi

export LC_COLLATE="en_GB.UTF-8"
export LC_CTYPE="en_GB.UTF-8"
export LC_MESSAGES="en_GB.UTF-8"
export LC_MONETARY="en_GB.UTF-8"
export LC_NUMERIC="en_GB.UTF-8"
export LC_TIME="en_GB.UTF-8"
export LC_ALL="en_GB.UTF-8"
export LESSCHARSET=utf-8

# Customize to your needs...
BIN_PATH="$HOME/bin:$HOME/local/bin" # Add ~/bin to PATH
CABAL_PATH="$HOME/.cabal/bin"
STACK_INSTALL_PATH="$HOME/.local/bin/"
KREW_PATH="${KREW_ROOT:-$HOME/.krew}/bin"

PATH=$CABAL_PATH:$STACK_INSTALL_PATH:$BIN_PATH:$KREW_PATH:$PATH
PATH="$HOME/.poetry/bin:$PATH"

case $OSTYPE in
darwin*)
  COREUTILS_PATH=$BREW_PREFIX/opt/coreutils/libexec/gnubin
  PATH=$COREUTILS_PATH:$PATH
  [ -x /opt/homebrew/bin/brew ] && eval "$(/opt/homebrew/bin/brew shellenv)"
  export ARCHFLAGS="-arch x86_64"
  ;;
*) ;;

esac

# eliminates duplicates in *paths
typeset -gU PATH cdpath fpath path
export PATH
