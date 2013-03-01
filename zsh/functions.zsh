
growl() {
  if [ $# -eq 1 ] ; then
    param="-m ${1}"
    growlnotify -m $1
  else
    title=$1
    shift 1
    param="-m ${@}"
    growlnotify $title $param
  fi

}

# Add good theme to list
good_theme() { echo $@ >> ~/dotfiles/config/zsh_themes }

# all-round man
man () {
/usr/bin/man $@ || (help $@ 2> /dev/null && help $@ | less)
}
