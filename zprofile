#echo 'zprofile' $0 # Debug

# Locale settings
export LANG="en_GB.UTF-8"
export LC_ALL="en_GB.UTF-8"

# Customize to your needs...
RVMS_PATH=$rvm_path:$rvm_bin_path # Add RVM to PATH for scripting
BIN_PATH=$HOME/bin:$HOME/local/bin # Add ~/bin to PATH
export NODE_PATH=/usr/local/lib/node_modules
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

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*
export ARCHFLAGS="-arch x86_64"
