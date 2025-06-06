# Adds node_modules/.bin to the PATH

npm_chpwd_hook() {
  if [ -n "${PRENPMPATH+x}" ]; then
    PATH=$PRENPMPATH
    unset PRENPMPATH
  fi
  if [ -f package.json ]; then
    PRENPMPATH=$PATH
    PATH=$(~/.asdf/plugins/nodejs/shims/npm prefix)/node_modules/.bin:$PATH
  fi
}

add-zsh-hook preexec npm_chpwd_hook
