# What need to be paid attention to is all the $, \, ` in single quote mark will not be processed
# specially, they will be treated as normal characters. This rule is common both in csh, bash, zsh.
# So we should prefer double quote mark in shell script.
alias cdf "cd ${DOTFILES}"
alias cdws "cd ${HOME}/workspaces"
alias venv "source ${DOTFILES}/venv/venv.csh"

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
