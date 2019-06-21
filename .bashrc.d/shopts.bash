# file: ~/.bashrc.d/shopt.bash

CDPATH=".:~:~/Dokumente:~/Downloads:~/src"

HISTCONTROL="ignorespace:erasedups"

HISTFILE="~/.bash_history"

HISTFILESIZE=10000

HISTIGNORE="&:[ ]*:exit:ls:bg:fg:history:clear"

HISTSIZE=50000

INPUTRC="~/.inputrc"

shopt -s cdable_vars

shopt -s cdspell

shopt -s checkhash

# Bash won't get SIGWINCH if another process is in the foreground.
# Enable checkwinsize so that bash will check the terminal size when
# it regains control.  #65623
# http://cnswww.cns.cwru.edu/~chet/bash/FAQ (E11)
shopt -s checkwinsize

shopt -s cmdhist

shopt -s expand_aliases

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

shopt -s histappend

shopt -s histverify

set -o vi
