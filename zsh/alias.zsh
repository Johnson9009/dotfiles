# What need to be paid attention to is all the $, \, ` in single quote mark will not be processed
# specially, they will be treated as normal characters. This rule is common both in csh, bash, zsh.
# So we should prefer double quote mark in shell script.
alias cdf="cd ${DOTFILES}"
alias cdws="cd ${HOME}/workspaces"
alias venv="source ${DOTFILES}/venv/venv.zsh $@"

# Put local aliases in ~/.local.alias.zsh, they'll stay out of your main dotfiles repository (which
# maybe public on the internet, like this one). Any alias can be defined safely, because this is the
# last alias configuration file current shell will load.
if [[ -a ~/.local.alias.zsh ]]; then
    source ~/.local.alias.zsh
fi

