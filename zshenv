#!/usr/bin/env zsh
#echo 'zshenv' $0 # Debug
# zmodload zsh/datetime
# setopt PROMPT_SUBST
# PS4='+$EPOCHREALTIME %N:%i> '

# logfile=$(mktemp zsh_profile.XXXXXXXX)
# echo "Logging to $logfile"
# exec 3>&2 2>$logfile

# setopt XTRACE

export SYSTEM=$(uname -s)
export ZHISTFILE=.histfile
if [[ -n $(whence -p brew) ]]; then
  export BREW_PREFIX=$(brew --prefix)
else
  export BREW_PREFIX=/opt/homebrew
fi

# https://github.com/sorin-ionescu/prezto/blob/master/runcoms/zshenv
# Ensure that a non-login, non-interactive shell has a defined environment.
if [[ ("$SHLVL" -eq 1 && ! -o LOGIN) && -s "${ZDOTDIR:-$HOME}/.zprofile" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprofile"
fi
