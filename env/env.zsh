export EDITOR=em
export TERM=xterm-256color
# Firstly we need to remove the exist path if it has been added, "${HOME}" should
# be used instead of "~" in order to make "sed" work correctly.
export PATH=${DOTFILES}/bin:`echo ${PATH} | sed -e "s|${DOTFILES}/bin:||g"`

