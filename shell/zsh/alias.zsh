# If aliases are surrounded by double quote mark, then variable substitution($)
# and command substitution(`) will be done when this file is processed, in
# another word, the variable and command substitution will be applied when
# aliases are defined. However, most of time, this isn't what we expect.
# Surrounding aliases with single quote mark will prevent this behavior, all of
# "$" and "`" inside single quote mark will be retained when shell interprets
# the alias definition statements, and variable and command substitution will be
# applied when aliases are used.
# So we should prefer single quote mark in alias definition. Single quote mark
# can be escaped through two ways `\'` and `"'"`, but the way `\'` has something
# different from other program languages, it can't work inside two paired single
# quote marks, i.e., it should be outside of single quote marks like this
# `'xxx'\''quoted'\''yyy'`.
#
# Z shell Specific
# 1. Alias can't support parameter, so alias that needs parameter only can be
#    implemented as function.
# 2. All parts of the alias target must be surrounded by quote marks.
# 3. Line continuation in alias target can be achieved using a backslash, but
#    the behavior is different when the backslash is used in below 3 ways.
#    - Backslash Outside of Quote Marks
#      There shouldn't be any white-space characters ahead of the quote mark of
#      next line, otherwise the next line will be omitted.
#    - Backslash Inside of Single Quote Marks
#      All of backslash, `\n` and white-space characters inside single quote
#      marks will be kept, but alias still work well.
#    - Backslash Inside of Double Quote Marks
#      Line continuation works as expectation, white-space characters inside
#      double quote marks will be kept.

# In order to avoid duplicate implementation of the same logic on each shell,
# logic should be moved to external script as much as possible. For the
# circumstances which must do something inside current shell process(e.g.,
# export environment variable, modify prompt string), let external script output
# the final statements, which need to be executed inside current shell process,
# according to the shell type, and then evaluate the final statements in current
# shell using command `source-stdin`.
#
# `source-stdin`: evaluate multiple line commands from standard input
# Usage:
#   commands_generator | source-stdin
# The output of `commands_generator` can be evaluated through two ways, the 1st
# one is evaluating result of command substitution of `commands_generator`(e.g.,
# eval `commands_generator`), and the 2nd one is piping the standard output of
# `commands_generator` to command `source` like here. For the 1st way, because
# the command substitution method "``" can't support nest, so
# `commands_generator` can't be an alias which contains command substitution
# "``" in it, therefore the 2nd way is used.
# Command `source` only accept file as its input, in order to let it evaluate
# commands from standard input, `pipe` is needed.
# 1. `pipe` will send the standard output of `commands_generator` to the
#    standard input of `source`. Unlike `grep`, `source` won't regard the
#    standard input as its input when the input isn't given, so here still need
#    specify /dev/fd/0 as the input of `source`.
# 2. `/dev/std*` are not POSIX standard(e.g., Termux hasn't `/dev/stdin`),
#    `/dev/fd/*` are more portable, it can work well on Mac OS, WSL, Msys2,
#    Ubuntu, CentOS, Termux.
alias source-stdin='source /dev/fd/0'
alias alias-it='alias'

# For the circumstances that adding more values to a exist environment variable,
# firstly the exist old value need to be removed if it has been added, with the
# help of aliases "addenvfront" and "addenvback", it become so easy. In
# addition, "${HOME}" should be used instead of "~" in order to make "sed" work
# correctly in any shell. For example, appending "${HOME}/bin" to the
# environment variable "PATH" can be achieved through something like below.
#     addenvback PATH ${HOME}/bin
# Z shell provides syntax level support for double substitution, i.e., ${(P)XX}.
# In addition, if the environment variable is set or not needn't to be check
# before calling "echo" command, because "echo" will just output empty string if
# it is not set.
addenvfront() { export ${1}="${2}:`echo ${(P)1} | sed -e "s|${2}:||g"`" }
addenvback()  { export ${1}="`echo ${(P)1} | sed -e "s|:${2}||g"`:${2}" }
# Export the environment variable to the first existing command.
# Usage:
#   env2cmd env_name cmd1 cmd2 cmd3 ...
env2cmd() { cmd_str-setenv2first_exist_cmd zsh ${@} | source-stdin }

# Load common alias of multiple different shells.
source ${DOTFILES}/shell/alias.sh

alias-it venv='source ${DOTFILES}/venv/venv.zsh'
