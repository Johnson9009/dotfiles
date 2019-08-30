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
# In zsh, alias can't support parameter, so alias that needs parameter only can
# be implemented as function.

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
# For bash and zsh, command `eval` can support multiple line evaluation, so just
# need alias `meval` to `eval`. In order to retain the result of command
# substitution as a whole instead of several separated words, the command
# substitution need to be surrounded by double quote mark.
alias meval='eval'

alias cdf='cd ${DOTFILES}'
alias cdws='cd ${HOME}/workspaces'
alias sudo='sudo -H'
alias venv='source ${DOTFILES}/venv/venv.zsh'
alias ag='ag --color-line-number=32 --color-path=35 --color-match="1;31" --nogroup'

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
env2cmd() { meval "`cmd_str-setenv2first_exist_cmd zsh ${@}`" }
