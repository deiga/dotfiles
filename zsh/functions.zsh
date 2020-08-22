# General shell functions

autoload -U up-line-or-beginning-search
autoload -U down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search

growl() {
  if [ $# -eq 1 ]; then
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
man() {
  /usr/bin/man "$@" || (help "$@" 2>/dev/null && help "$@" | less)
}

password() {
  openssl rand -base64 32
}

fzf-open-file-with-vim() {
  vim $(fzf)
}

iterm2_print_user_vars() {
  # iterm2_set_user_var k8s_context $(kubectl config current-context)
  # iterm2_set_user_var k8s_namespace $(kubectl config view --minify --output 'jsonpath={..namespace}')
  # iterm2_set_user_var tf_workspace $(tf workspace show)
}

dockerfilelint() {
  local DOCKERFILE=${1:-Dockerfile}
  docker run -v $(pwd)/$DOCKERFILE:/Dockerfile replicated/dockerfilelint /Dockerfile
}

zle -N fzf-open-file-with-vim

source $HOME/dotfiles/config/docker-fzf/functions.sh
