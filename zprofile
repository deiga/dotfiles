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
PYTHON_BIN_PATH="$HOME/Library/Python/3.7/bin"
KREW_PATH="${KREW_ROOT:-$HOME/.krew}/bin"

PATH=$CABAL_PATH:$STACK_INSTALL_PATH:$PYTHON_BIN_PATH:$BIN_PATH:$KREW_PATH:$PATH
PATH="$HOME/.poetry/bin:$PATH"

case $OSTYPE in
darwin*)
  PYTHON_HOMEBREW_PATH=$BREW_PREFIX/opt/python/libexec/bin
  COREUTILS_PATH=$BREW_PREFIX/opt/coreutils/libexec/gnubin
  HOMEBREW_PATH=$BREW_PREFIX/sbin:$BREW_PREFIX/bin
  PATH=$COREUTILS_PATH:$PYTHON_HOMEBREW_PATH:$HOMEBREW_PATH:$PATH
  # PATH=$PYTHON_HOMEBREW_PATH:$HOMEBREW_PATH:$PATH
  export ARCHFLAGS="-arch x86_64"
  export JAVA_HOME
  JAVA_HOME=/Library/Java/JavaVirtualMachines/openjdk.jdk/Contents/Home # Update with /usr/libexec/java_home
  export SCALA_HOME=$BREW_PREFIX/opt/scala
  ;;
*) ;;

esac

# eliminates duplicates in *paths
typeset -gU PATH cdpath fpath path
export PATH

if type fasd >/dev/null; then eval "$(fasd --init auto)"; fi
if type thefuck >/dev/null; then eval "$(thefuck --alias)"; fi
