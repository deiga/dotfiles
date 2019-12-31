export WORKON_HOME=$HOME/Dropbox/.virtualenvs
export PROJECT_HOME=$HOME/Dropbox/Documents/Projects
export PIP_DOWNLOAD_CACHE=$HOME/.pip/cache
export PYTHONSTARTUP=$HOME/.pythonrc

export ENHANCD_COMMAND=ecd
export EDITOR=vim
export VISUAL=code

export FZF_DEFAULT_COMMAND='rg --files --no-ignore --hidden --follow -g "!{.git,node_modules}/*" 2> /dev/null'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

if [ -f $HOME/Dropbox/Avaimet/shell/secrets.sh ]; then source $HOME/Dropbox/Avaimet/shell/secrets.sh; fi
