# file: ~/.bashrc.d/functions.bash

# ----------------------------------------------------------------------------
# Functions
# ----------------------------------------------------------------------------

# show colors
colors() {
  local fgc bgc vals seq0

  printf "Color escapes are %s\n" '\e[${value};...;${value}m'
  printf "Values 30..37 are \e[33mforeground colors\e[m\n"
  printf "Values 40..47 are \e[43mbackground colors\e[m\n"
  printf "Value  1 gives a  \e[1mbold-faced look\e[m\n\n"

  # foreground colors
  for fgc in {30..37}; do
    # background colors
    for bgc in {40..47}; do
      fgc="${fgc#37}" # white
      bgc="${bgc#40}" # black

      vals="${fgc:+$fgc;}${bgc}"
      vals="${vals%%;}"

      seq0="${vals:+\e[${vals}m}"
      printf "  %-9s" "${seq0:-(default)}"
      printf " %sTEXT\e[m" "${seq0}"
      printf " \e[%s1mBOLD\e[m" "${vals:+${vals+$vals;}}"
    done
    echo; echo
  done
}

# ex - archive extractor
# usage: ex <file>
ex() {
  if [ -f "$1" ] ; then
    case "$1" in
      *.tar.bz2)   tar xjf "$1"   ;;
      *.tar.gz)    tar xzf "$1"   ;;
      *.bz2)       bunzip2 "$1"   ;;
      *.rar)       unrar x "$1"   ;;
      *.gz)        gunzip "$1"    ;;
      *.tar)       tar xf "$1"    ;;
      *.tbz2)      tar xjf "$1"   ;;
      *.tgz)       tar xzf "$1"   ;;
      *.zip)       unzip "$1"     ;;
      *.Z)         uncompress "$1";;
      *.7z)        7z x "$1"      ;;
      *)           echo "'$1' cannot be extracted via ex()" ;;
    esac
  else
    echo "'$1' is not a valid file"
  fi
}

# up 2 = cd ../../
upup() { 
  DEEP=$1; \
  [ -z "${DEEP}" ] && { DEEP=1; }; \
  for i in $(seq 1 ${DEEP}); do cd ../; done; 
}

replace-all() {
  if [[ ! "$1" ]] ; then
    echo "You must supply a search string."
    return 1
  fi
    if [[ ! "$2" ]] ; then
    echo "You must supply a replacement string."
    return 1
  fi

  for file in `find . -type f -exec grep -l "${1}" {} \;`; do \
  sed -i "s/${1}/${2}/g" $file; done;
}
