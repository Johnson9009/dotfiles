#!/bin/sh
usage() {
    cat <<EOF
USAGE: \${DOTFILES}/shell/csh/launcher.sh <function> [arg ...]

FUNCTION:
  exit <return_code>
EOF
}

# Print usage if not specify the function that need to run.
if [ $# -eq 0 ]; then
    usage
    exit 1
fi

# Execute the specified function.
case ${1} in
    exit)
        exit ${2}
        ;;
    *)
        cat <<EOF
Error: Specify unknow function "${1}",
       this shell script now only support run function "exit".

EOF
        usage
        exit 1
        ;;
esac
