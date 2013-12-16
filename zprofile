#echo 'zprofile' $0 # Debug
#setopt xtrace # Trace
#setopt promptsubst
#typeset -F SECONDS
#PS4='+{$SECONDS}%N:%i> '

# Locale settings
export LANG="en_GB.UTF-8"
export LC_ALL="en_GB.UTF-8"

# Customize to your needs...
BIN_PATH=$HOME/bin:$HOME/local/bin # Add ~/bin to PATH
BOX_PATH=$HOME/dotfiles/box/bin # Add path for box
PATH=$BIN_PATH:$BOX_PATH:$PATH

case $OSTYPE in
    darwin*)
        COREUTILS_PATH=/usr/local/opt/coreutils/libexec/gnubin
        HOMEBREW_PATH=/usr/local/sbin:/usr/local/bin
        PATH=$COREUTILS_PATH:$HOMEBREW_PATH:$PATH
        export RBENV_ROOT=/usr/local/var/rbenv
        export ARCHFLAGS="-arch x86_64"
        # export PYTHONPATH=/usr/local/lib/python2.7/site-packages:$PYTHONPATH
    ;;
    *)
        export RBENV_ROOT=~/.rbenv
    ;;
esac

typeset -U PATH
export PATH

# Make path system wide for OS X
case $OSTYPE in
    darwin*)
        launchctl setenv PATH $PATH
    ;;
esac

eval "$(rbenv init - --no-rehash)"
if [[ ! $(type perlbrew) =~ "shell function" ]]; then source ~/perl5/perlbrew/etc/bashrc; fi
if [[ ! $(type nvm) =~ "shell function" ]]; then [[ -s ~/.nvm/nvm.sh ]] && . ~/.nvm/nvm.sh  ; fi
