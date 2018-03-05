# General shell functions

autoload -U up-line-or-beginning-search
autoload -U down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search

growl() {
  if [ $# -eq 1 ] ; then
    param="-m ${1}"
    growlnotify -m "$1"
  else
    title=$1
    shift 1
    param="-m ${@}"
    growlnotify "$title" "$param"
  fi

}

# all-round man
man () {
/usr/bin/man "$@" || (help "$@" 2> /dev/null && help "$@" | less)
}

password() {
    openssl rand -base64 32
}

gpip2(){
   PIP_REQUIRE_VIRTUALENV="" pip2 "$@"
}

gpip3(){
   PIP_REQUIRE_VIRTUALENV="" pip3 "$@"
}

gpip(){
  gpip3 "$@"
}

fzf-open-file-with-vim() {
  vim $(fzf)
}

zle -N fzf-open-file-with-vim

source $HOME/dotfiles/config/git-fzf/functions.sh
