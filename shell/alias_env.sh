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
alias-it rg rg --no-heading


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
# `$$` is the `PID` of the current shell, function `pid-path` of `sh_launcher`
# get the absolute path of the current shell through command `pidpath` and the
# proc file system, the prerequisite of command `pidpath` works well is ensuring
# it can be found in `${PATH}` before the execution of below line of code.
# Finally, `which xsh` is used to cover the worst situation.
setenv SHELL `sh_launcher pid-path $$ || which ${XSH}`
# Terminal emulator can't set the environment variable `TERM` of remote server
# without any server side administrator configuration, so it need to be set by
# shell self.
setenv TERM xterm-256color
# Set locale and language settings correctly, then shell will know how to show
# the Non-ASCII characters.
setenv LC_CTYPE en_US.UTF-8
setenv LC_ALL en_US.UTF-8
