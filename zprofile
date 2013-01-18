#[[ -r $rvm_path/scripts/completion ]] && . $rvm_path/scripts/completion
eval $(ssh-agent)
ssh-add

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*

export PATH=$PATH:/usr/local/share/npm/bin:/bin:/usr/sbin:/sbin:/usr/local/bin:/usr:$HOME/bin
