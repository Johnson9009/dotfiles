#!/bin/sh
case $(basename $0) in
    emacs)
        exec emacsx -nw $@
        ;;
    em)
        exec emacsclient -t -a "" $@
        ;;
    emx)
        exec emacsclient -c -a "" $@
        ;;
    *)
        echo "Error: Running from unknow symbolic link \"$0\", this shell script only can be"
        echo "       run through symbolic link and now 'emacs', 'em', 'emx' are supported."
        exit 1
        ;;
esac
