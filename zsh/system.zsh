# System dependent settings

case $OSTYPE in
    # OS X specifics
    darwin*)
        alias manpdf="man -t $0 | ps2pdf - - | open -f -a Preview"

        # Use keychain for HTTPS git
        (git config --global credential.helper osxkeychain &) 2> /dev/null

        source ~/bin/osx_functions.sh

        ;;
    *)
        # Cache credentials for 60min for HTTPS git
        (git config credential.helper 'cache --timeout=3600' &) 2> /dev/null
        memrss () {
            while read command percent rss; do 
                if [[ "${command}" != "COMMAND" ]]; then 
                    rss="$(bc <<< "scale=2;${rss}/1024")"; 
                fi; 
                printf "%-26s%-8s%s\n" "${command}" "${percent}" "${rss}"; 
            done < <(ps -A --sort -rss -o comm,pmem,rss | head -n 20)
        }
        ;;
esac

export ROO_OPTS="-Xms1G -Xmx1G"
