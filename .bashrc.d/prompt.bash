# file: ~/.bashrc.d/prompt.bash

use_color=true

# Set colorful PS1 only on colorful terminals.
# dircolors --print-database uses its own built-in database
# instead of using /etc/DIR_COLORS.  Try to use the external file
# first to take advantage of user additions.  Use internal bash
# globbing instead of external grep binary.

safe_term=${TERM//[^[:alnum:]]/?}   # sanitize TERM
match_lhs=""

[[ -f ~/.dir_colors   ]] && match_lhs="${match_lhs}$(<~/.dir_colors)"
[[ -f /etc/DIR_COLORS ]] && match_lhs="${match_lhs}$(</etc/DIR_COLORS)"

[[ -z ${match_lhs}    ]] \
  && type -P dircolors >/dev/null \
  && match_lhs=$(dircolors --print-database)

[[ $'\n'${match_lhs} == *$'\n'"TERM "${safe_term}* ]] && use_color=true

if "${use_color}" ; then
  # Enable colors for ls, etc.  Prefer ~/.dir_colors #64489
  if type -P dircolors >/dev/null ; then
    if [[ -f ~/.dir_colors ]] ; then
      eval "$(dircolors -b ~/.dir_colors)"
    elif [[ -f /etc/DIR_COLORS ]] ; then
      eval "$(dircolors -b /etc/DIR_COLORS)"
    fi
  fi
  
  RED='\[\033[01;31m\]'
  GREEN='\[\033[01;32m\]'
  YELLOW='\[\033[01;33m\]'
  GRAY='\[\033[00m\]'

  PS1_USER="$GREEN[\u@\h$GRAY \w$GREEN]\$\[\033[00m\] "
  PS1_ROOT="$RED[\h$GRAY \w$RED]#\[\033[00m\] "
  PS1_SSH_USER="$GREEN[$YELLOW\u@\h$GRAY \w$GREEN]\$\[\033[00m\] "
  PS1_SSH_ROOT="$RED[$YELLOW\h$GRAY \w$RED]#\[\033[00m\] "

  if [[ $SSH_CONNECTION ]] ; then
    [[ ${EUID} == 0 ]] && PS1=$PS1_SSH_ROOT || PS1=$PS1_SSH_USER
  else
    [[ ${EUID} == 0 ]] && PS1=$PS1_ROOT || PS1=$PS1_USER
  fi
else
  [[ ${EUID} == 0 ]] && PS1='\u@\h \W \# ' || PS1='\u@\h \w \$ '
fi

#-----------------------------------------------------------------------
#  set Bash prompts for vim-bash-support
#  PS4 shows the function name when execution is inside a function and
#  the xtrace option is set.
#-----------------------------------------------------------------------
export PS2='continue> '
export PS3='choose: '
export PS4='|${BASH_SOURCE} ${LINENO}${FUNCNAME[0]:+ ${FUNCNAME[0]}()}| '

unset use_color safe_term match_lhs sh RED GREEN YELLOW GRAY \
  PS1_USER PS1_ROOT PS1_SSH_USER PS1_SSH_ROOT
