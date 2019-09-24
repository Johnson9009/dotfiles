# 1. Aliases
#
# All aliases in this file are commonly used by all shells, and all of them have
# the same definition between all shells. Because the syntax of the built-in
# command `alias` of each shell is different, and redefine shells' built-in
# command `alias` is not a good idea, so `alias-it` is used here and all of
# shells need to implement it. The syntax of `alias-it` chose that of c shell,
# but current only support argument `!*`.

alias-it sh_launcher '${DOTFILES}'/shell/launcher.sh
# Export the environment variable to the first existing command.
# Usage:
#   env2cmd env_name cmd1 cmd2 cmd3 ...
alias-it env2cmd sh_launcher cmd_str-setenv2first_exist_cmd '\!* |' source-stdin
alias-it cdf cd '${DOTFILES}'
alias-it cdws cd '${HOME}'/workspaces
alias-it sudo sudo -H
alias-it venv source '${DOTFILES}/venv/venv.${XSH}'
alias-it ag ag --color-line-number=32 --color-path=35 --color-match='"1;31"'\
            --nogroup


# 2. Environment Variables
#
# All environment variables defined in this file are commonly used by all
# shells, and all of them have the same definition between all shells.
# Environment variable definition command `setenv` of c shell is chosen
# here, so other shells need to implement it.

# Environment variable `SHELL`(along with some other variables, e.g., HOME and
# USER) is set by the process that logs you in. It is set to the login shell
# value set in the passwd database (/etc/passwd). In order to reflect the shell
# you're currently using, it need to be updated during shell launching.
#
# The most reliable way to get the real full path of the current shell is
# consulting the proc file system, `$$` is the `PID` of the current shell, so
# `/proc/$$/exe` is linked to the real full path of the current shell. The proc
# file system way works well on almost every platform, e.g. linux, MSYS2, WSL,
# and even Android, except Mac OS, because Mac OS doesn't support the proc file
# system natively, so `which xsh` is adopted when the proc file system way
# failed.
setenv SHELL `readlink -n /proc/$$/exe || which ${XSH}`
# Terminal emulator can't set the environment variable `TERM` of remote server
# without any server side administrator configuration, so it need to be set by
# shell self.
setenv TERM xterm-256color
