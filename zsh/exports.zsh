
export PIP_REQUIRE_VIRTUALENV=true
export WORKON_HOME=$HOME/Dropbox/.virtualenvs
export PROJECT_HOME=$HOME/Dropbox/Documents/Projects
export VIRTUALENVWRAPPER_SCRIPT=/usr/local/bin/virtualenvwrapper.sh
export VIRTUALENVWRAPPER_VIRTUALENV_ARGS='--no-site-packages'
export PIP_DOWNLOAD_CACHE=$HOME/.pip/cache
export PYTHONSTARTUP=$HOME/.pythonrc

if [ -f /usr/local/bin/virtualenvwrapper_lazy.sh ]; then source /usr/local/bin/virtualenvwrapper_lazy.sh; fi
if [ -f $HOME/Dropbox/Avaimet/shell/secrets.sh ]; then source $HOME/Dropbox/Avaimet/shell/secrets.sh; fi
