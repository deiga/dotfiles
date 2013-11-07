#echo 'zprofile' $0 # Debug

# Locale settings
export LANG="en_GB.UTF-8"
export LC_ALL="en_GB.UTF-8"

export NODE_PATH=/usr/local/lib/node_modules
export RBENV_ROOT=/usr/local/var/rbenv
export ARCHFLAGS="-arch x86_64"

# Customize to your needs...
BIN_PATH=$HOME/bin:$HOME/local/bin # Add ~/bin to PATH
BOX_PATH=$HOME/dotfiles/box/bin # Add path for box
PATH=$BIN_PATH:$BOX_PATH:$PATH

case $OSTYPE in
    darwin*)
        COREUTILS_PATH=/usr/local/opt/coreutils/libexec/gnubin
        HOMEBREW_PATH=/usr/local/sbin:/usr/local/bin
        PATH=$COREUTILS_PATH:$HOMEBREW_PATH:$PATH
        # export PYTHONPATH=/usr/local/lib/python2.7/site-packages:$PYTHONPATH
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

if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi
if which perlbrew > /dev/null; then source ~/perl5/perlbrew/etc/bashrc; fi
