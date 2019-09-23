#!/bin/sh

# Usage:
#   cmd_str_setenv2first_exist_cmd env_name cmd1 cmd2 cmd3 ...
# Output the command string, which is used to export the specified environment
# variable to the first existing command.
# Because this script will be executed by `/bin/sh`, so it will only search the
# commands from `PATH` environment variable, if the command is a alias or its
# path is not in `PATH`, then it will be treated as a none existing command.
cmd_str_setenv2first_exist_cmd() {
    export_str="export ${1}="
    # Remove the first argument "environment variable name".
    shift 1

    for cmd in ${@}; do
        if $(command -v ${cmd} > /dev/null 2>&1); then
            exist_cmd=${cmd}
            break
        fi
    done

    if [ -z ${exist_cmd} ]; then
        cat <<EOF
cat <<EOG
cmd_str-setenv2first_exist_cmd:
Error: None of "${@}" is found.
EOG
false
EOF
        return 1
    else
        echo "${export_str}${exist_cmd}"
        return 0
    fi
}

# The function name is just the symbolic link name when this shell script is run
# through symbolic link.
func_name=$(basename ${0})
# The function name is the first argument when this shell script is run
# directly.
if [ "${func_name}" = "launcher.sh" ]; then
    func_name=${1}
    # Remove the first argument "function name".
    shift 1
fi

# Dispatch to the corresponding function.
case ${func_name} in
    cmd_str-setenv2first_exist_cmd)
        cmd_str_setenv2first_exist_cmd ${@}
        ;;
    *)
        cat <<EOF
Error: Unknow function "${func_name}",
       now only function "cmd_str_setenv2first_exist_cmd" is supported.
EOF
        exit 1
        ;;
esac
