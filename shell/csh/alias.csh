# If aliases are surrounded by double quote mark, then variable substitution($)
# and command substitution(`) will be done when this file is processed, in
# another word, the variable and command substitution will be applied when
# aliases are defined. However, most of time, this isn't what we expect.
# Surrounding aliases with single quote mark will prevent this behavior, all of
# "$" and "`" inside single quote mark will be retained, when shell interprets
# the alias definition statements, and variable and command substitution will be
# applied when aliases are used.
# So we should prefer single quote mark in alias definition.
#
# In csh, function aren't supported, but alias can support parameter, so simple
# function can be implemented by alias.

# In order to avoid duplicate implementation of the same logic on each shell,
# logic should be moved to external script as much as possible. For the
# circumstances which must do something inside current shell process(e.g.,
# export environment variable, modify prompt string), let external script output
# the final statements, which need to be executed inside current shell process,
# according to the shell type, and then evaluate the final statements in current
# shell using command `meval`.
#
# `meval`: `eval` command that supports multiple line evaluation
# Usage:
#   meval "command substitution"
# For tcsh and csh, command `eval` can't support multiple line evaluation, so
# only command `source` can help, but `source` only accept file as its input, in
# order to let `source` work well on multiple line command string, it need
# collaborate with `pipe` and standard input.
# 1. `pipe` will send the standard output of `printf` to the standard input of
#    `source`. Unlike `grep`, `source` won't regard the standard input as its
#    input when the input isn't given, so here still need specify /dev/fd/0 as
#    the input of `source`.
# 2. `/dev/std*` are not POSIX standard(e.g., Termux hasn't `/dev/stdin`),
#    `/dev/fd/*` are more portable, it can work well on Mac OS, WSL, Msys2,
#    Ubuntu, CentOS, Termux.
# For tcsh and csh, surrounding command substitution with double quote mark only
# can prevent blanks and tabs separate the result, newlines still will separate
# the result to several words. So command `printf` is needed to combine these
# separated words back to one entirety.
# 1. `printf "%s\n"` will append newline to the end of each word, it will
#    process all of words one by one.
alias meval 'printf "%s\n" \!:* | source /dev/fd/0'

alias cdf 'cd ${DOTFILES}'
alias cdws 'cd ${HOME}/workspaces'
alias sudo 'sudo -H'
alias venv 'source ${DOTFILES}/venv/venv.csh'
alias ag 'ag --color-line-number=32 --color-path=35 --color-match="1;31"'\
         '--nogroup'

# For the circumstances that adding more values to a exist environment variable, firstly the exist
# old value need to be removed if it has been added, with the help of aliases "addenvfront" and
# "addenvback", it become so easy. In addition, "${HOME}" should be used instead of "~" in order to
# make "sed" work correctly in any shell. For example, appending "${HOME}/bin" to the environment
# variable "PATH" can be achieved through something like below.
#     addenvback PATH ${HOME}/bin
# In C shell "echo" will error out when the environment variable is not set, therefore whether the
# environment variable is set or not need to be check firstly. Alias of C shell can't support
# complete if statement which need to be written as multiple lines, so "test" command need to be
# used with "&&" and "||" to simulate the complete if statement. In addition, alias of C shell have
# not syntax level support for double substitution, so it only can be done by "eval" command.
alias addenvfront 'test $?\!:1 != 1 && setenv \!:1 \!:2\: ||'\
                  'test $?\!:1 != 0 && setenv \!:1 \!:2\:`eval echo ${\!:1} | sed -e "s|\!:2\:||g"`'
alias addenvback  'test $?\!:1 != 1 && setenv \!:1 :\!:2 ||'\
                  'test $?\!:1 != 0 && setenv \!:1 `eval echo ${\!:1} | sed -e "s|:\!:2||g"`:\!:2'
# Export the environment variable to the first existing command.
# Usage:
#   env2cmd env_name cmd1 cmd2 cmd3 ...
alias env2cmd 'meval "`cmd_str-setenv2first_exist_cmd csh \!:*`"'
