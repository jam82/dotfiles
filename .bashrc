#===============================================================================
#
#          FILE: .bashrc
# 
#   DESCRIPTION: jam82's .bashrc
# 
#        AUTHOR: Jonas Mauer (jam82), jam@kabelmail.net
#       CREATED: 29.12.2017 19:42:40
#      REVISION: 1.0.0
#
#===============================================================================

# If not running interactively, don't do anything from here
[[ $- != *i* ]] && return

# source .bash files
function source_when_true {
  local bash_file
  for bash_file in "$HOME"/$1/*.bash ; do
    [[ -f "$bash_file" && -r "$bash_file" ]] && source "$bash_file"
  done
  unset $bash_file
}

source_when_true '.bashrc.d'

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/bash lesspipe)"

# better yaourt colors
export YAOURT_COLORS="nb=1:pkg=1:ver=1;32:lver=1;45:installed=1;42:grp=1;34:od=1;41;5:votes=1;44:dsc=0:other=1;35"

# colored GCC warnings and errors
export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'
