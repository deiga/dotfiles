# Use `hub` as our git wrapper:
#   http://defunkt.github.com/hub/
hub_path=$(which hub)
if (( $+commands[hub] ))
then
  alias git=$hub_path
fi

# ls aliases
alias ls='ls $LS_OPTIONS -hF'
alias la='ls $LS_OPTIONS -lhAF'
alias ll='ls $LS_OPTIONS -lhF'

# added interactive and verbose mode for common file operations
alias cp="cp -iv"
alias mv="mv -iv"
alias rm="rm -vi"
