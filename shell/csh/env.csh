# The most reliable way to get the real full path of the current shell is
# consulting the proc file system, `$$` is the `PID` of the current shell, so
# `/proc/$$/exe` is linked to the real full path of the current shell. The proc
# file system way works well on almost every platform, e.g. linux, MSYS2, WSL,
# and even Android, except Mac OS, because Mac OS doesn't support the proc file
# system natively, so `which csh` is adopted when the proc file system way
# failed.
setenv SHELL `readlink -n /proc/$$/exe || which csh`
setenv TERM xterm-256color
