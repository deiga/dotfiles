[[ -s "$HOME/.rvm/scripts/rvm" ]] && . "$HOME/.rvm/scripts/rvm" # This loads RVM into a shell session.
#[[ -r $rvm_path/scripts/completion ]] && . $rvm_path/scripts/completion
eval $(ssh-agent)
ssh-add
