# Used here and functions.zsh is included later on

git_main_branch() {
  git remote show origin | sed -n '/HEAD branch/s/.*: //p'
}

eval "$(hub alias -s)"

# Detect which `ls` flavor is in use
if ls --color >/dev/null 2>&1; then # GNU `ls`
  colorflag="--color"
else # OS X `ls`
  colorflag="-G"
fi

# ls aliases
lsflags="-hF"
alias ls="ls ${colorflag} ${lsflags}"
alias la="ls ${colorflag} ${lsflags} -lA"
alias ll="ls ${colorflag} ${lsflags} -l"

# added interactive and verbose mode for common file operations
alias cp="cp -v"
alias mv="mv -iv"
alias rm="rm -vi"

# Enable aliases to be sudo’ed
alias sudo='sudo '

# Enable locate db update
alias updatedb='/usr/libexec/locate.updatedb'

# Make mkdir use -p
alias mkdir='mkdir -p'

alias reload="source ~/.zshrc"

alias epoch="date +%s"

# Git aliases
alias g="git"
alias gtts="g co $(git_main_branch) && g pull && g sync"
alias gts="g fetch --all && g rebase origin/$(git_main_branch)"
alias gcl="GIT_TEMPLATE_DIR=$HOME/.git_template g cl"
# END git

alias time='gtime -f '\''%Us user %Ss system %es real %MkB mem -- %C'\'

alias less="less -N"

# k8s aliases
alias k="kubectl"
alias kx="kubectx"

alias tfws="terraform workspace select"
alias tfwl="terraform workspace list"

# amboss
alias tfp="tfws production; terraform"
alias tfs="tfws staging; terraform"
alias tfq="tfws qa; terraform"

alias tg="terragrunt"
alias tgp="terragrunt plan -lock=false"

alias mux=tmuxinator
