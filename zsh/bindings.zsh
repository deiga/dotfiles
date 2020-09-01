# ZSH Keybindings

bindkey '\e[3~' delete-char

bindkey "$terminfo[kcuu1]" up-line-or-beginning-search   # Up
bindkey "$terminfo[kcud1]" down-line-or-beginning-search # Down
bindkey "^P" up-line-or-beginning-search
bindkey "^N" down-line-or-beginning-search

# bindkey "^P"  fzf-open-file-with-vim

# bindkey "^[c" fzf-cd-widget
