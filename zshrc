# Profiling
# zmodload zsh/zprof

# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=10000
SAVEHIST=10000
setopt appendhistory autocd nomatch
bindkey -v
# End of lines configured by zsh-newuser-install

# The following lines were added by compinstall
# zstyle :compinstall filename '~/.zshrc'

# autoload -Uz compinit
# compinit
# End of lines added by compinstall

# oh-my-zsh

# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.

# Comment this out to disable weekly auto-update checks
DISABLE_AUTO_UPDATE="true"

# Uncomment following line if you want to disable autosetting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment following line if you want disable red dots displayed while waiting for completion
# DISABLE_COMPLETION_WAITING_DOTS="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
plugins=(autojump bower brew bundler coffee extract gem git-flow-avh git gitfast heroku history-substring-search node npm nvm ssh-agent tmux web-search zsh-syntax-highlighting)

source $ZSH/oh-my-zsh.sh
# end oh-my-zsh

# Set editor
export EDITOR=vim
set -o vi

# Announces todays date
today=`date "+%m.%d.%Y"`

# Keybindings
bindkey '\e[3~' delete-char
bindkey '^R' history-incremental-search-backward

autoload -U up-line-or-beginning-search
autoload -U down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search
bindkey "^[[A" up-line-or-beginning-search # Up
bindkey "^[[B" down-line-or-beginning-search # Down

# Colors
autoload -U colors && colors
setopt prompt_subst

eval `dircolors ~/.dir_colors`

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
  source $file
done

if [ `uname` = "Darwin" ]; then
    source /usr/local/lib/python2.7/site-packages/powerline/bindings/zsh/powerline.zsh # Add powerline to zsh
else
    source ~/local/lib/python2.7/site-packages/powerline/bindings/zsh/powerline.zsh # Add powerline to zsh
fi

fpath=(/usr/local/share/zsh-completions $fpath)

# Profiling end
# zprof

