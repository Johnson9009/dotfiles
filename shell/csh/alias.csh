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
# C shell Specific
# 1. Function aren't supported, but alias can support parameter, so simple
#    function can be implemented by alias.
# 2. It needn't surround all parts of alias target with quote marks, all of text
#    behind the alias name is treated as alias target automatically, so only
#    surround the necessary parts are enough.
# 3. Line continuation in alias target can be achieved using a backslash, and
#    all(include 0) of white-space characters ahead of the first meaningful
#    character of the next line will be replaced to one space character.

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
# 3. The ahead command `sed` is an ugly workaround of tcsh and csh built-in
#    command `source` bug,  the bug cause the last `\n` is not processed, so the
#    old prompt will not disappear and the new prompt will adjoin the old one,
#    in addition, the next command will regard the not processed `\n` as user
#    input. The bug will only happen when below two conditions are satisfied.
#    - The commands are piped to `source` like here
#    - The last command of the commands is tcsh and csh built-in command
#    The workaround is appending an external command, which only return the exit
#    code of previous command, to commands through command `sed`.
alias source-stdin sed -e \''$a ${DOTFILES}/shell/csh/launcher.sh exit $?'"' |"\
                   source /dev/fd/0
# Implement other shells built-in command `export` using command `setenv`.
alias export echo setenv '\!* |' sed -e "'s/=/ /' |" source-stdin
# Support to define aliases using other shells' style, the single quote marks of
# alias target will be stript by shell when pass to command `echo`, so add it
# back.
alias alias-it 'echo alias \!*'"\' | sed -e 's/=/ \x27/' | source-stdin"
# In csh, the script which is executed through command `source` only can return
# through command `exit`, and the shell process will not exit. In other
# shells(e.g., bash, zsh), the sourced script need to use command `return` to
# return, if the command `exit` is used, the shell process will exit.
alias return exit

# For the circumstances that adding more values to a exist environment variable,
# firstly the exist old value need to be removed if it has been added, with the
# help of aliases "addenvfront" and "addenvback", it become so easy. In
# addition, "${HOME}" should be used instead of "~" in order to make "sed" work
# correctly in any shell. For example, appending "${HOME}/bin" to the
# environment variable "PATH" can be achieved through something like below.
#     addenvback PATH ${HOME}/bin
# In C shell "echo" will error out when the environment variable is not set,
# therefore whether the environment variable is set or not need to be check
# firstly. Alias of C shell can't support complete if statement which need to be
# written as multiple lines, so "test" command need to be used with "&&" and
# "||" to simulate the complete if statement. In addition, alias of C shell have
# not syntax level support for double substitution, so it only can be done by
# "eval" command.
alias addenvfront 'test $?\!:1 != 1 && setenv \!:1 \!:2\: ||'\
                  'test $?\!:1 != 0 && setenv \!:1 \!:2\:`eval echo ${\!:1} | sed -e "s|\!:2\:||g"`'
alias addenvback  'test $?\!:1 != 1 && setenv \!:1 :\!:2 ||'\
                  'test $?\!:1 != 0 && setenv \!:1 `eval echo ${\!:1} | sed -e "s|:\!:2||g"`:\!:2'
# Export the environment variable to the first existing command.
# Usage:
#   env2cmd env_name cmd1 cmd2 cmd3 ...
alias env2cmd cmd_str-setenv2first_exist_cmd '\!:* |' source-stdin

# Load common alias of multiple different shells.
source ${DOTFILES}/shell/alias.sh

alias-it venv='source ${DOTFILES}/venv/venv.csh'
