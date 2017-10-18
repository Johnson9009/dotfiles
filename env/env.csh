setenv EDITOR em
setenv TERM xterm-256color
if (":$PATH:" =~ *:${DOTFILES}/bin:*) then
else
    setenv PATH ${DOTFILES}/bin:${PATH}
endif
