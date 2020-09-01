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

# fasd & fzf change directory - jump using `fasd` if given argument, filter output of `fasd` using `fzf` else
z() {
  [ $# -gt 0 ] && fasd_cd -d "$*" && return
  local dir
  dir="$(fasd -Rdl "$1" | fzf -1 -0 --no-sort +m)" && cd "${dir}" || return 1
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

source $HOME/dotfiles/config/docker-fzf/functions.sh

aq() {
  aws-vault exec amboss-qa-mfa -- "$@"
}
as() {
  aws-vault exec amboss-staging-mfa -- "$@"
}
ap() {
  aws-vault exec amboss-prod-mfa -- "$@"
}

environments=(
  aq:q:amboss-qa-de          #kq hq
  aq:qu:amboss-qa-us         #kqu hqu
  as:s:amboss-staging-de     #ks hs
  as:su:amboss-staging-us    #ksu hsu
  ap:p:amboss-production-de  #kp hp
  ap:pu:amboss-production-us #kpu hpu
  ap:i:infrastructure        #ki hi
)

aqs() {
  aws-vault exec --server amboss-qa-mfa -- "$@"
}
ass() {
  aws-vault exec --server amboss-staging-mfa -- "$@"
}
aps() {
  aws-vault exec --server amboss-prod-mfa -- "$@"
}

aq-gui() {
  aws-vault exec --server --prompt=osascript amboss-qa-mfa -- open -a "$@"
}
as-gui() {
  aws-vault exec --server --prompt=osascript amboss-staging-mfa -- open -a "$@"
}
ap-gui() {
  aws-vault exec --server --prompt=osascript amboss-prod-mfa -- open -a "$@"
}

for e in ${environments[@]}; do
  IFS=: read aws_vault_command command_shorthand context_name <<<"${e}"
  eval "function k${command_shorthand}() {
    ${aws_vault_command} kubectl \$@ --context ${context_name}
  }"
  eval "function h${command_shorthand}() {
    ${aws_vault_command} helm --kube-context ${context_name} \$@
  }"
done

ocq() {
  aq octant --context amboss-qa-de --namespace web-services-qa
}
ocs() {
  as octant --context amboss-staging-de --namespace web-services-staging
}
ocp() {
  ap octant --context amboss-production-de --namespace web-services-production
}

lensq() {
  aq /Applications/Lens.app/Contents/MacOS/Lens
}

lenss() {
  as /Applications/Lens.app/Contents/MacOS/Lens
}

lensp() {
  ap /Applications/Lens.app/Contents/MacOS/Lens
}

kres() {
  stage=${1:-qa}
  region=${2:-de}
  aws-vault exec amboss-${stage}-mfa -- kubectl --context amboss-${stage}-${region} get nodes --no-headers | awk '{print $1}' | xargs -I {} sh -c "echo   {} ; aws-vault exec amboss-${stage}-mfa -- kubectl --context amboss-${stage}-${region} describe node {} | grep Allocated -A 5 | grep -ve Event -ve Allocated -ve percent -ve -- ; echo "
}

kalloc() {
  stage=${1:-qa}
  region=${2:-de}
  aws-vault exec amboss-${stage}-mfa -- kubectl get pods -o custom-columns='NAME:.metadata.name,CPU(cores):.spec.containers[*].resources.requests.cpu,CPU Limit:.spec.containers[*].resources.limits.cpu,MEMORY(bytes):.spec.containers[*].resources.requests.memory,MEMORY Limit:.spec.containers[*].resources.limits.memory' --all-namespaces

}

autoload aq as ap kns ks ksu kq kqu kp kpu ki kres hs hq hp hsu hqu hpu hi kalloc
