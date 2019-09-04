#!/bin/sh
usage() {
    cat <<EOF
USAGE: \${DOTFILES}/shell/csh/launcher.sh <function> [arg ...]

FUNCTION:
  cmd_str-exit_dollar_question_mark_by_self
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
    cmd_str-exit_dollar_question_mark_by_self)
        cat <<EOF
\${DOTFILES}/shell/csh/launcher.sh exit \$?
EOF
        ;;
    exit)
        exit ${2}
        ;;
    *)
        cat <<EOF
Error: Specify unknow function "${1}",
       this shell script now only support run function
       "cmd_str-exit_dollar_question_mark_by_self" and "exit".

EOF
        usage
        exit 1
        ;;
esac
