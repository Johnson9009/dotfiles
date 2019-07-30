# What need to be paid attention to is all the $, \, ` in single quote mark will not be processed
# specially, they will be treated as normal characters. This rule is common both in csh, bash, zsh.
# So we should prefer double quote mark in shell script. In addition, in zsh alias can't support to
# process arguments, so aliases that need arguments only can be implemented as zsh function.
alias cdf="cd ${DOTFILES}"
alias cdws="cd ${HOME}/workspaces"
alias sudo="sudo -H"
alias venv="source ${DOTFILES}/venv/venv.zsh"
alias ag="ag --color-line-number=32 --color-path=35 --color-match='1;31' --nogroup"

# For the circumstances that adding more values to a exist environment variable, firstly the exist
# old value need to be removed if it has been added, with the help of aliases "addenvfront" and
# "addenvback", it become so easy. In addition, "${HOME}" should be used instead of "~" in order to
# make "sed" work correctly in any shell. For example, appending "${HOME}/bin" to the environment
# variable "PATH" can be achieved through something like below.
#     addenvback PATH ${HOME}/bin
# Z shell provides syntax level support for double substitution, i.e., ${(P)XX}. In addition, if the
# environment variable is set or not needn't to be check before calling "echo" command, because
# "echo" will just output empty string if it is not set.
addenvfront() { export ${1}="${2}:`echo ${(P)1} | sed -e "s|${2}:||g"`" }
addenvback()  { export ${1}="`echo ${(P)1} | sed -e "s|:${2}||g"`:${2}" }
