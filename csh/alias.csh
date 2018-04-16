# What need to be paid attention to is all the $, \, ` in single quote mark will not be processed
# specially, they will be treated as normal characters. This rule is common both in csh, bash, zsh.
# So we should prefer double quote mark in shell script.
alias cdf "cd ${DOTFILES}"
alias cdws "cd ${HOME}/workspaces"
alias venv "source ${DOTFILES}/venv/venv.csh \!:*"
