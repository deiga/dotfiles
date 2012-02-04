# Announces today's date
today=`date "+%m.%d.%Y"`

set -o vi

export LC_ALL="en_GB.UTF-8"

export HOME=~/
export PATH=/usr/local/bin:$PATH
export PATH=$PATH:$HOME/bin
export PATH=$PATH:/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/sbin
export MANPATH=/opt/local/share/man:/user/local/man:$MANPATH
export INFO=/usr/local/share/info:$INFO
export HISTSIZE=10000
export HISTFILESIZE=10000
export HISTCONTROL=ignoredups
export EDITOR=vim
export HISTTIMEFORMAT="%m/%d/%y - %H:%M:%S "

# Bash tips and tricks for History related preferences
# see http://richbradshaw.wordpress.com/2007/11/25/bash-tips-and-tricks/

# == 1 Lost bash history ==
# the bash history is only saved when you close the terminal, not after each command. fix it..
shopt -s histappend
PROMPT_COMMAND='history -a'

# == 3. Duplicate entries in bash history ==
# This will ignore duplicates, as well as ls, bg, fg and exit as well, making for a cleaner bash history.
export HISTIGNORE="&:ls:[bf]g:exit"

# == 4 Multiple line commands split up in history ==
# this will change multiple line commands into single lines for easy editing.
shopt -s cmdhist

# Terminal colours (after installing GNU coreutils)
NM="\[\033[0;38m\]" #means no background and white lines
HI="\[\033[0;37m\]" #change this for letter colors
HII="\[\033[0;31m\]" #change this for letter colors
SI="\[\033[0;33m\]" #this is for the current directory
IN="\[\033[0m\]"
BR="\[\033[1;30m\]"

# Command prompt "layout"
export PS1="$BR[ $HI\u @ $HII\h $BR] $SI\w $BR\$ $IN"
export PS2='>'

# Setting color options for ls
if [ "$TERM" != "dumb" ]; then
        export LS_OPTIONS='--color=auto'
        eval `dircolors ~/.dir_colors`
fi

# ls aliases
alias ls='ls $LS_OPTIONS -hF'
alias la='ls $LS_OPTIONS -lAhF'
alias ll='ls $LS_OPTIONS -lhF'

# cd typo fixes
alias cd..="cd .."
alias ..="cd .."

# shorten aliases
alias c="clear"
alias e="exit"

# open typo fixes
alias opne="open"
alias open.="open ."

# added interactive and verbose mode for common file operations
alias cp="cp -iv"
alias mv="mv -iv"
alias rm="rm -vi"

alias manpdf="man -t $0 | ps2pdf - - | open -f -a Preview"

##
# DELUXE-USR-LOCAL-BIN-INSERT
# (do not remove this comment)
##
echo $PATH | grep -q -s "/usr/local/bin"
if [ $? -eq 1 ] ; then
            PATH=$PATH:/usr/local/bin
            export PATH
fi

test -r /sw/bin/init.sh && . /sw/bin/init.sh

man () {
/usr/bin/man $@ || (help $@ 2> /dev/null && help $@ | less)
}
