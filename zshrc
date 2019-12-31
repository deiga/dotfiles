#!/usr/bin/bash
#echo 'zshrc' $0 # Debug
# Profiling
# zmodload zsh/zprof

HISTFILE=~/.histfile
HISTSIZE=10000
SAVEHIST=10000
setopt appendhistory autocd nomatch
# zle uses vi mode
bindkey -v

zstyle :omz:plugins:ssh-agent agent-forwarding on
# zstyle :omz:plugins:ssh-agent identities keys/github_ed25519 keys/bitbucket_ed25519 keys/kapsi_ed25519 keys/gitlab_ed25519 keys/heroku_ed25519

source $HOME/.zsh/plugins/antigen.zsh

if [ -f $HOME/dotfiles/config/enhancd/init.sh ]; then source $HOME/dotfiles/config/enhancd/init.sh; fi

# Set editor
set -o vi

# Colors
autoload -U colors && colors
setopt prompt_subst

eval $(dircolors ~/.dir_colors)

# ZSH Hooks
autoload -U add-zsh-hook

# Disable correct
if [ -f ~/.zsh_nocorrect ]; then
    while read -r COMMAND; do
        alias $COMMAND="nocorrect $COMMAND"
    done < ~/.zsh_nocorrect
fi

# all of our zsh files
typeset -U config_files
config_files=(~/.zsh/*.zsh)

# load the path files
for file in $config_files
do
  source "$file"
done

init_files=(~/.zsh/init/*.*sh)

for file in $init_files
do
    source "$file" || true
done

setopt extendedglob

tmux list-sessions 2> /dev/null


if [ $commands[kubectl] ]; then source <(kubectl completion zsh); fi
zstyle ':completion:*' completer _expand _complete _ignored _approximate
zstyle :compinstall filename '/Users/timosand/.zshrc'

test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"
if command brew >/dev/null 2>&1; then
  fpath+=$(brew --prefix)/share/zsh/site-functions
fi
fpath+=~/.zsh/Completion

autoload -Uz compinit && compinit

# Profiling end
# zprof
