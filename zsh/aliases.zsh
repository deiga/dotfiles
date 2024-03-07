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

alias hax="osascript -e 'Display notification \"WTF R U DOIN\" with title \"Activity Monitor\" subtitle \"System Error\"'"

alias epoch="date +%s"
alias g="git"
alias gtts="gt trunk && gt sync"
alias gtt="gt trunk"
alias gts="gt sync"
alias gcl="GIT_TEMPLATE_DIR=$HOME/.git_template g cl"

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
