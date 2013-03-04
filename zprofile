#[[ -r $rvm_path/scripts/completion ]] && . $rvm_path/scripts/completion

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*
export PATH=/usr/local/sbin:$rvm_path:$rvm_bin_path:$PATH # Add RVM to PATH for scripting
