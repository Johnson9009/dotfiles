setenv EDITOR em
setenv TERM xterm-256color
# Firstly we need to remove the exist path if it has been added, "${HOME}" should
# be used instead of "~" in order to make "sed" work correctly.
setenv PATH ${DOTFILES}/bin:`echo ${PATH} | sed -e "s|${DOTFILES}/bin:||g"`

