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

# The function name is the first argument.
func_name=${1}
# Remove the first argument "function name".
shift 1

# Dispatch to the corresponding function.
case ${func_name} in
    exit)
        exit ${@}
        ;;
    *)
        cat <<EOF
Error: Specify unknow function "${func_name}",
       this shell script now only support run function "exit".
EOF
        usage
        exit 1
        ;;
esac
