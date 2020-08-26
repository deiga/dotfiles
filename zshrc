# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

#echo 'zshrc' $0 # Debug
# Profiling
#zmodload zsh/zprof

zstyle ':completion:*' completer _expand _complete _ignored _approximate
zstyle :compinstall filename '/Users/timosand/.zshrc'
zstyle ':completion:*' accept-exact '*(N)'
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path ~/.zsh/cache

if type brew >/dev/null 2>&1; then
  fpath+=$BREW_PREFIX/share/zsh/site-functions
fi
fpath+=~/.zsh/Completion

autoload -Uz compinit
if [[ -n ${ZDOTDIR:-${HOME}}/.zcompdump(.mh1) ]]; then
	compinit;
else
	compinit -C;
fi;

HISTFILE=~/.histfile
HISTSIZE=10000
SAVEHIST=10000
setopt appendhistory autocd nomatch
# zle uses vi mode
bindkey -v

# append history list to the history file; this is the default but we make sure
# because it's required for share_history.
setopt append_history

# import new commands from the history file also in other zsh-session
setopt share_history

# save each command's beginning timestamp and the duration to the history file
setopt extended_history

# If a new command line being added to the history list duplicates an older
# one, the older command is removed from the list
setopt histignorealldups

# remove command lines from the history list when the first character on the
# line is a space
setopt histignorespace

# if a command is issued that can't be executed as a normal command, and the
# command is the name of a directory, perform the cd command to that directory.
setopt auto_cd

# in order to use #, ~ and ^ for filename generation grep word
# *~(*.gz|*.bz|*.bz2|*.zip|*.Z) -> searches for word not in compressed files
# don't forget to quote '^', '~' and '#'!
setopt extended_glob

# display PID when suspending processes as well
setopt longlistjobs

# report the status of backgrounds jobs immediately
setopt notify

# whenever a command completion is attempted, make sure the entire command path
# is hashed first.
setopt hash_list_all

# not just at the end
setopt completeinword

# Don't send SIGHUP to background processes when the shell exits.
setopt nohup

# make cd push the old directory onto the directory stack.
setopt auto_pushd

# avoid "beep"ing
setopt nobeep

# don't push the same dir twice.
setopt pushd_ignore_dups

# * shouldn't match dotfiles. ever.
setopt noglobdots

# use zsh style word splitting
setopt noshwordsplit

zstyle :omz:plugins:ssh-agent agent-forwarding on
# zstyle :omz:plugins:ssh-agent identities keys/github_ed25519 keys/bitbucket_ed25519 keys/kapsi_ed25519 keys/gitlab_ed25519 keys/heroku_ed25519

# source $HOME/.zsh/plugins/antigen.zsh
source $HOME/.zsh/plugins.zsh

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
  done <~/.zsh_nocorrect
fi

# all of our zsh files
typeset -U config_files
config_files=(~/.zsh/*.zsh)

# load the path files
for file in "${config_files[@]}"; do
  source "$file"
done

init_files=(~/.zsh/init/*.*sh)

for file in "${init_files[@]}"; do
  source "$file" || true
done

setopt extendedglob

tmux list-sessions 2>/dev/null

test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# Profiling end
#zprof
