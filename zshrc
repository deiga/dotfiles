# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=10000
SAVEHIST=10000
setopt appendhistory autocd nomatch
bindkey -v
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '~/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall

# Set editor
export EDITOR=vim
set -o vi

# Locale settings
export LC_ALL="en_GB.UTF-8"

# PATH settings
export PATH=/usr/local/bin:$PATH
export PATH=$PATH:$HOME/bin

# Announces todays date
today=`date "+%m.%d.%Y"`

# Keybindings
bindkey '\e[3~' delete-char
bindkey '^R' history-incremental-search-backward

# RVM
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"
export RAILS_ENV="development"

# Colors
autoload -U colors
colors
setopt prompt_subst

# Prompt
local smiley="%(?,%{$fg[green]%}☺%{$reset_color%},%{$fg[red]%}☹%{$reset_color%})"

PROMPT='
%~
${smiley} %{$reset_color%}$fg_bold[white]%n$fg[grey]@%{$fg[red]%}%m%{$reset_color%} %% '

RPROMPT='%{$fg[white]%} $(~/.rvm/bin/rvm-prompt)$(~/bin/git-cwd-info)%{$reset_color%}'

# Replace the above with this if you use rbenv
# RPROMPT='%{$fg[white]%} $(~/.rbenv/bin/rbenv version-name)$(~/bin/git-cwd-info.rb)%{$reset_color%}'

# Show completion on first TAB
setopt menucomplete

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
