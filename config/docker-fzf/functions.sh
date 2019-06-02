# MIT License
# 
# Copyright (c) 2019 Carlos Castaño
# 
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
# 
# The above copyright notice and this permission notice shall be included in all
# copies or substantial portions of the Software.
# 
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.

runc() {
  export FZF_DEFAULT_OPTS='--height 90% --reverse --border'
  local image=$(docker images --format '{{.Repository}}:{{.Tag}}' | fzf-tmux --reverse --multi)
  if [[ $image != '' ]]; then
    echo -e "\n  \033[1mDocker image:\033[0m" $image
    read -e -p $'  \e[1mOptions: \e[0m' -i "-it --rm" options

    printf "  \033[1mChoose the command: \033[0m"
    local cmd=$(echo -e "/bin/bash\nsh" | fzf-tmux --reverse --multi)
    if [[ $cmd == '' ]]; then
        read -e -p $'  \e[1mCustom command: \e[0m' cmd
    fi
    echo -e "  \033[1mCommand: \033[0m" $cmd

    export FZF_DEFAULT_COMMAND='find ./ -type d -maxdepth 1 -exec basename {} \;'
    printf "  \033[1mChoose the volume: \033[0m"
    local volume=$(fzf-tmux --reverse --multi)
    local curDir=${PWD##*/}
    if [[ $volume == '.' ]]; then
        echo -e "  \033[1mVolume: \033[0m" $volume
        volume="`pwd`:/$curDir -w /$curDir"
    else
        echo -e "  \033[1mVolume: \033[0m" $volume
        volume="`pwd`/$volume:/$volume -w /$volume"
    fi

    export FZF_DEFAULT_COMMAND=""
    export FZF_DEFAULT_OPTS=""

    history -s runc
    history -s docker run $options -v $volume $image $cmd
    echo ''
    docker run $options -v $volume $image $cmd
  fi
}

runinc() {
  export FZF_DEFAULT_OPTS='--height 90% --reverse --border'
  local container=$(docker ps --format '{{.Names}} => {{.Image}}' | fzf-tmux --reverse --multi | awk -F '\\=>' '{print $1}')
  if [[ $container != '' ]]; then
    echo -e "\n  \033[1mDocker container:\033[0m" $container
    read -e -p $'  \e[1mOptions: \e[0m' -i "-it" options
    if [[ $@ == '' ]]; then
				read -e -p $'  \e[1mCommand: \e[0m' cmd
    else
				cmd="$@"
    fi
    echo ''
    history -s runinc "$@"
    history -s docker exec $options $container $cmd
    docker exec $options $container $cmd
    echo ''
  fi
  export FZF_DEFAULT_OPTS=""
}

stopc() {
  export FZF_DEFAULT_OPTS='--height 90% --reverse --border'
  local container=$(docker ps --format '{{.Names}} => {{.Image}}' | fzf-tmux --reverse --multi | awk -F '\\=>' '{print $1}')
  if [[ $container != '' ]]; then
    echo -e "\n  \033[1mDocker container:\033[0m" $container
    printf "  \033[1mRemove?: \033[0m"
    local cmd=$(echo -e "No\nYes" | fzf-tmux --reverse --multi)
    if [[ $cmd != '' ]]; then
      if [[ $cmd == 'No' ]]; then
        echo -e "\n  Stopping $container ...\n"
        history -s stopc
        history -s docker stop $container
        docker stop $container > /dev/null
      else
        echo -e "\n  Stopping $container ..."
        history -s stopc
        history -s docker stop $container
        docker stop $container > /dev/null

        echo -e "  Removing $container ...\n"
        history -s stopc
        history -s docker rm $container
        docker rm $container > /dev/null
      fi
    fi
  fi
  export FZF_DEFAULT_OPTS=""
}