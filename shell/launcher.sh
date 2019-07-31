#!/bin/sh

# Usage:
#   cmd_str_setenv2first_exist_cmd shell_type env_name cmd1 cmd2 cmd3 ...
# Output the command string, which is used to export the specified environment
# variable to the first existing command, according to the shell type.
# Because this script will be executed by `/bin/sh`, so it will only search the
# commands from `PATH` environment variable, if the command is a alias or its
# path is not in `PATH`, then it will be treated as a none existing command.
cmd_str_setenv2first_exist_cmd() {
    case ${1} in
        csh)
            export_str="setenv ${2} "
            ;;
        bash)
            export_str="export ${2}="
            ;;
        zsh)
            export_str="export ${2}="
            ;;
        *)
            cat <<EOF
cat <<EOG
cmd_str-setenv2first_exist_cmd:
Error: Unsupported Shell "${1}", now only csh, bash, zsh are supported.
EOG
false
EOF
            return 1
            ;;
    esac

    # Remove the first 2 positional arguments "shell type" and "environment
    # variable".
    shift 2

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

# Dispatch to the corresponding function according to caller name.
case $(basename ${0}) in
    cmd_str-setenv2first_exist_cmd)
        cmd_str_setenv2first_exist_cmd ${@}
        ;;
    *)
        cat <<EOF
Error: Running from unknow symbolic link "${0}",
       this shell script only can be run through symbolic link and now
       "cmd_str-setenv2first_exist_cmd" is supported.
EOF
        exit 1
        ;;
esac
