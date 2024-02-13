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

zle -N fzf-open-file-with-vim

iterm2_print_user_vars() {
  # iterm2_set_user_var k8s_context $(kubectl config current-context)
  # iterm2_set_user_var k8s_namespace $(kubectl config view --minify --output 'jsonpath={..namespace}')
  # iterm2_set_user_var tf_workspace $(tf workspace show)
}

dockerfilelint() {
  local DOCKERFILE=${1:-Dockerfile}
  docker run -v $(pwd)/$DOCKERFILE:/Dockerfile replicated/dockerfilelint /Dockerfile
}

source $HOME/dotfiles/config/docker-fzf/functions.sh

environments=(
  q:amboss-qa-de          #kq hq
  qu:amboss-qa-us         #kqu hqu
  s:amboss-staging-de     #ks hs
  su:amboss-staging-us    #ksu hsu
  p:amboss-production-de  #kp hp
  pu:amboss-production-us #kpu hpu
  i:infrastructure        #ki hi
)

for e in ${environments[@]}; do
  IFS=: read command_shorthand context_name <<<"${e}"
  eval "function k${command_shorthand}() {
    kubectl \$@ --context ${context_name}
  }"
  eval "function h${command_shorthand}() {
    helm --kube-context ${context_name} \$@
  }"
done

kres() {
  stage=${1:-qa}
  region=${2:-de}
  kubectl --context amboss-${stage}-${region} get nodes --no-headers | awk '{print $1}' | xargs -I {} sh -c "echo   {} ; kubectl --context amboss-${stage}-${region} describe node {} | grep Allocated -A 5 | grep -ve Event -ve Allocated -ve percent -ve -- ; echo "
}

kalloc() {
  stage=${1:-qa}
  region=${2:-de}
  kubectl get pods -o custom-columns='NAME:.metadata.name,CPU(cores):.spec.containers[*].resources.requests.cpu,CPU Limit:.spec.containers[*].resources.limits.cpu,MEMORY(bytes):.spec.containers[*].resources.requests.memory,MEMORY Limit:.spec.containers[*].resources.limits.memory' --all-namespaces

}

autoload aq as ap kns ks ksu kq kqu kp kpu ki kres hs hq hp hsu hqu hpu hi kalloc
