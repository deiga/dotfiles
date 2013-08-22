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
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(autojump gem heroku brew command-coloring ssh-agent screen npm node history-substring-search)

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

# Colors
autoload -U colors && colors
setopt prompt_subst

# Prompt
#local smiley="%(?,%{$fg[green]%}☺%{$reset_color%},%{$fg[red]%}☹%{$reset_color%})"

#PROMPT='
#%~
#${smiley} %{$reset_color%}$fg_bold[white]%n$fg[grey]@%{$fg[red]%}%m%{$reset_color%} %% '

#RPROMPT='%{$fg[white]%} $(~/.rvm/bin/rvm-prompt)$(~/bin/git-cwd-info)%{$reset_color%}'

# Replace the above with this if you use rbenv
# RPROMPT='%{$fg[white]%} $(~/.rbenv/bin/rbenv version-name)$(~/bin/git-cwd-info.rb)%{$reset_color%}'

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

source /usr/local/lib/python2.7/site-packages/powerline/bindings/zsh/powerline.zsh # Add powerline to zsh

# Profiling end
# zprof

PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting
