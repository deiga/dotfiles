eval "$(hub alias -s)"

# Detect which `ls` flavor is in use
if ls --color > /dev/null 2>&1; then # GNU `ls`
  colorflag="--color"
else # OS X `ls`
  colorflag="-G"
fi

# ls aliases
lsflags="-hF"
alias ls="ls ${colorflag} ${lsflags}"
alias la="ls ${colorflag} ${lsflags} -lA"
alias ll="ls ${colorflag} ${lsflags} -l"

# added interactive and verbose mode for common file operations
alias cp="cp -v"
alias mv="mv -iv"
alias rm="rm -vi"

# Enable aliases to be sudo’ed
alias sudo='sudo '

# Enable locate db update
alias updatedb='/usr/libexec/locate.updatedb'

# Make mkdir use -p
alias mkdir='mkdir -p'

# Flush Directory Service cache
alias flush="dscacheutil -flushcache && killall -HUP mDNSResponder"

# Clean up LaunchServices to remove duplicates in the “Open With” menu
alias lscleanup="/System/Library/Frameworks/CoreServices.framework/Frameworks/LaunchServices.framework/Support/lsregister -kill -r -domain local -domain system -domain user && killall Finder"

# Empty the Trash on all mounted volumes and the main HDD
# Also, clear Apple’s System Logs to improve shell startup speed
alias emptytrash="sudo rm -rfv /Volumes/*/.Trashes; sudo rm -rfv ~/.Trash; sudo rm -rfv /private/var/log/asl/*.asl"

# One of @janmoesen’s ProTip™s
for method in GET HEAD POST PUT DELETE TRACE OPTIONS; do
  alias "$method"="lwp-request -m '$method'"
done

alias reload="source ~/.zshrc"

# Stuff I never really use but cannot delete either because of http://xkcd.com/530/
alias stfu="osascript -e 'set volume output muted true'"
alias pumpitup="osascript -e 'set volume 7'"
alias hax="growlnotify -a 'Activity Monitor' 'System error' -m 'WTF R U DOIN'"

alias bower="noglob bower"
alias epoch="date +%s"
alias g="git"
