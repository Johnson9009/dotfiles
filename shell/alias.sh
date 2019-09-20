# All aliases in this file are commonly used by all shells, and all of them have
# the same definition between all shells. Because the built-in command `alias`
# of csh can't be aliased to other command, so `alias-it` is used here and all
# of shells need to implement it. The alias writing style here chose that of
# bash and zsh.
alias-it cdf='cd ${DOTFILES}'
alias-it cdws='cd ${HOME}/workspaces'
alias-it sudo='sudo -H'
alias-it ag='ag --color-line-number=32 --color-path=35 --color-match="1;31" '\
'--nogroup'
