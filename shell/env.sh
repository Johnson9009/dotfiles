# All environment variables defined in this file are commonly used by all
# shells, and all of them have the same definition between all shells.
# Environment variable definition command `export` of bash and zsh is chosen
# here, so csh need to implement it.

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
# system natively, so command `lsof` is adopted when the proc file system way
# failed.
export SHELL=`readlink -n /proc/$$/exe ||\
              lsof -Ffn0 -wp $$ |\
              sed -nE '/^ftxt\x0n/{s|^ftxt\x0n([^(]+).*\x0$|\1|;s/ *$//;p}'`
# Terminal emulator can't set the environment variable `TERM` of remote server
# without any server side administrator configuration, so it need to be set by
# shell self.
export TERM=xterm-256color
