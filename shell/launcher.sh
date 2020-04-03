#!/bin/sh

# Usage:
#   download2client client_destination_dir [-r] <file_or_dir>...
# Download files or directories to the current ssh client machine through
# command `scp`, now only support the `-r` option of command `scp`, and `-r` can
# appear at any position.
download2client() {
    client_destination_dir="${SSH_CONNECTION%% *}:${1}"
    # Remove the first argument "destination directory of ssh client machine".
    shift 1

    for arg in ${@}; do
        case ${arg} in
            -*)
                options="${options} ${arg}"
                ;;
            *)
                files_or_dirs="${files_or_dirs} ${arg}"
                ;;
        esac
    done

    scp ${options} ${files_or_dirs} ${client_destination_dir}
}

# Usage:
#   upload2here client_source_dir [-r] <file_or_dir>...
# Upload files or directories from the current ssh client machine to the current
# directory through command `scp`, now only support the `-r` option of command
# `scp`, and `-r` can appear at any position.
upload2here() {
    client_source_dir="${SSH_CONNECTION%% *}:${1}"
    # Remove the first argument "source directory of ssh client machine".
    shift 1

    for arg in ${@}; do
        case ${arg} in
            -*)
                options="${options} ${arg}"
                ;;
            *)
                files_or_dirs="${files_or_dirs} ${client_source_dir}/${arg}"
                ;;
        esac
    done

    scp ${options} ${files_or_dirs} ./
}

# Return the absolute path of the specified process.
# Usage:
#   pid_path PID
# The most reliable way to do that is consulting the proc file system using the
# process ID(`PID`), `/proc/${PID}/exe` is linked to the absolute path of the
# specified process. The proc file system way works well on almost every
# platform(e.g. linux, MSYS2, WSL, and even Android), except Mac OS, because
# Mac OS doesn't support the proc file system natively, so here prefer to get it
# through command `[pidpath](https://github.com/cirocosta/pidpath)`.
pid_path() {
    pid=${1}
    if $(command -v pidpath > /dev/null 2>&1); then
        pidpath ${pid}
    else
        readlink -n /proc/${pid}/exe
    fi
}

# Output the command string, which is used to export the specified environment
# variable to the first existing command.
# Usage:
#   cmd_str_setenv2first_exist_cmd env_name cmd1 cmd2 cmd3 ...
# Because this script will be executed by `/bin/sh`, so it will only search the
# commands from `PATH` environment variable, if the command is a alias or its
# path is not in `PATH`, then it will be treated as a none existing command.
cmd_str_setenv2first_exist_cmd() {
    setenv_str="setenv ${1} "
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
        echo "${setenv_str}${exist_cmd}"
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
    download2client)
        download2client ${@}
        ;;
    upload2here)
        upload2here ${@}
        ;;
    pid-path)
        pid_path ${@}
        ;;
    *)
        cat <<EOF
cat <<EOG
Error: Unknow function "${func_name}",
       now only function "download2client", "upload2here", "pid-path" and
       "cmd_str-setenv2first_exist_cmd" are supported.
EOG
false
EOF
        exit 1
        ;;
esac
