#[[ -r $rvm_path/scripts/completion ]] && . $rvm_path/scripts/completion

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*

# Customize to your needs...
RVM_PATH=$rvm_path:$rvm_bin_path # Add RVM to PATH for scripting
BIN_PATH=$HOME/bin # Add ~/bin to PATH
NPM_PATH=/usr/local/share/npm/bin # Add npm packages to PATH
BOX_PATH=$HOME/dotfiles/box/bin # Add path for box
PATH=$RVM_PATH:$BIN_PATH:$NPM_PATH:$BOX_PATH:$PATH
case $OSTYPE in
    darwin*)
        COREUTILS_PATH=/usr/local/opt/coreutils/libexec/gnubin
        HOMEBREW_PATH=/usr/local/sbin:/usr/local/bin
        PATH=$COREUTILS_PATH:$HOMEBREW_PATH:$PATH
    ;;
esac

typeset -U PATH
export PATH
