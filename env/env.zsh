export EDITOR=em
export TERM=xterm-256color
if [[ ":$PATH:" != *:${DOTFILES}/bin:* ]]; then
    export PATH=${DOTFILES}/bin:${PATH}
fi
