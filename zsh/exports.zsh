if [ -f $HOME/Dropbox/Avaimet/shell/secrets.sh ]; then source $HOME/Dropbox/Avaimet/shell/secrets.sh; fi

export WORKON_HOME=$HOME/Dropbox/.virtualenvs
export PROJECT_HOME=$HOME/Dropbox/Documents/Projects
export PIP_DOWNLOAD_CACHE=$HOME/.pip/cache
export PYTHONSTARTUP=$HOME/.pythonrc

export ENHANCD_COMMAND=ecd
export EDITOR=vim
export VISUAL=code

export COMPOSE_DOCKER_CLI_BUILD=1
export DOCKER_BUILDKIT=1
export CLOUDSDK_PYTHON=$(asdf where python 3.12.1)/bin/python # When updating this version mach it with the version in Asdffile

# export FZF_BASE=/usr/local/opt/fzf
export FZF_DEFAULT_COMMAND='rg --files --no-ignore --hidden --follow -g "!{.git,node_modules}/*" 2> /dev/null'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

export ZSH_WAKATIME_PROJECT_DETECTION=true

export PER_DIRECTORY_HISTORY_TOGGLE='^H'
