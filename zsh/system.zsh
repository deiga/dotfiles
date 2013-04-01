# System dependent settings

case $OSTYPE in
    # OS X specifics
    darwin*)
        alias manpdf="man -t $0 | ps2pdf - - | open -f -a Preview"

        # Use keychain for HTTPS git
        git config --global credential.helper osxkeychain

        source ~/bin/osx_functions.sh

        ;;
    *)
        # Cache credentials for 60min for HTTPS git
        git config credential.helper 'cache --timeout=3600'
        ;;
esac
