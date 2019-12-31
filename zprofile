#!/usr/bin/bash
# vim syn=zsh
#echo 'zprofile' $0 # Debug
#setopt xtrace # Trace
#setopt promptsubst
#typeset -F SECONDS
#PS4='+{$SECONDS}%N:%i> '
# Locale settings
export LANG="en_GB.UTF-8"
export LC_ALL="en_GB.UTF-8"

# Customize to your needs...
BIN_PATH="$HOME/bin:$HOME/local/bin" # Add ~/bin to PATH
CABAL_PATH="$HOME/.cabal/bin"
STACK_INSTALL_PATH="$HOME/.local/bin/"
PYTHON_BIN_PATH="$HOME/Library/Python/3.7/bin"

PATH=$CABAL_PATH:$STACK_INSTALL_PATH:$PYTHON_BIN_PATH:$PATH

case $OSTYPE in
darwin*)
  PYTHON_HOMEBREW_PATH=/usr/local/opt/python/libexec/bin
  COREUTILS_PATH=/usr/local/opt/coreutils/libexec/gnubin
  HOMEBREW_PATH=/usr/local/sbin:/usr/local/bin
  PATH=$COREUTILS_PATH:$PYTHON_HOMEBREW_PATH:$HOMEBREW_PATH:$PATH
  # PATH=$PYTHON_HOMEBREW_PATH:$HOMEBREW_PATH:$PATH
  export ARCHFLAGS="-arch x86_64"
  export JAVA_HOME
  JAVA_HOME=$(/usr/libexec/java_home)
  export SCALA_HOME=/usr/local/opt/scala
  ;;
*) ;;

esac

typeset -U PATH
export PATH

if type nodenv >/dev/null; then eval "$(nodenv init - --no-rehash)"; fi
if type fasd >/dev/null; then eval "$(fasd --init auto)"; fi
if type thefuck >/dev/null; then eval "$(thefuck --alias)"; fi
