
growl() { echo $'\e]9;'${1}'\007' ; return ; }

# Add good theme to list
good_theme() { echo $@ >> ~/dotfiles/config/zsh_themes }

# all-round man
man () {
/usr/bin/man $@ || (help $@ 2> /dev/null && help $@ | less)
}
