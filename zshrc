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
export ZSH_THEME="random"

# Set to this to use case-sensitive completion
# CASE_SENSITIVE="true"

# Comment this out to disable weekly auto-update checks
# DISABLE_AUTO_UPDATE="true"

# Uncomment following line if you want to disable colors in ls
# DISABLE_LS_COLORS="true"

# Uncomment following line if you want to disable autosetting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment following line if you want disable red dots displayed while waiting for completion
# DISABLE_COMPLETION_WAITING_DOTS="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(autojump bundler gem heroku rails3 rake ruby vi-mode git brew git-flow mvn osx svn command-coloring rvm)

source $ZSH/oh-my-zsh.sh

# Customize to your needs...
export PATH=/usr/local/sbin:/usr/local/share/npm/bin:/bin:/usr/sbin:/sbin:/usr/local/bin:/usr/bin:$HOME/bin:$PATH

# end oh-my-zsh

# Set editor
export EDITOR=vim
set -o vi

# Locale settings
export LC_ALL="en_GB.UTF-8"

# Announces todays date
today=`date "+%m.%d.%Y"`

# Keybindings
bindkey '\e[3~' delete-char
bindkey '^R' history-incremental-search-backward

# RVM
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"
export RAILS_ENV="development"

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

# OS X specifics
case `uname -a` in
    *Darwin*)
        alias manpdf="man -t $0 | ps2pdf - - | open -f -a Preview"
        export PATH="$(brew --prefix coreutils)/libexec/gnubin:$PATH"
        ;;
    *)
        echo "Darwin not found"
        ;;
esac

# Setting color options for ls
if [ "$TERM" != "dumb" ]; then
        export LS_OPTIONS='--color=auto'
        eval `dircolors ~/.dir_colors`
fi

# ls aliases
alias ls='ls $LS_OPTIONS -hF'
alias la='ls $LS_OPTIONS -lhAF'
alias ll='ls $LS_OPTIONS -lhF'

# added interactive and verbose mode for common file operations
alias cp="cp -iv"
alias mv="mv -iv"
alias rm="rm -vi"

# all-round man
man () {
/usr/bin/man $@ || (help $@ 2> /dev/null && help $@ | less)
}

PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting

# Disable correct
if [ -f ~/.zsh_nocorrect ]; then
    while read -r COMMAND; do
        alias $COMMAND="nocorrect $COMMAND"
    done < ~/.zsh_nocorrect
fi

growl() { echo $'\e]9;'${1}'\007' ; return ; }

# Make path system wide
launchctl setenv PATH $PATH

# RVM + iTerm2
__rvm_project_rvmrc
