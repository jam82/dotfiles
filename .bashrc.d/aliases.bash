# file: ~/.bashrc.d/aliases.bash

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
      fgc=${fgc#37} # white
      bgc=${bgc#40} # black

      vals="${fgc:+$fgc;}${bgc}"
      vals=${vals%%;}

      seq0="${vals:+\e[${vals}m}"
      printf "  %-9s" "${seq0:-(default)}"
      printf " ${seq0}TEXT\e[m"
      printf " \e[${vals:+${vals+$vals;}}1mBOLD\e[m"
    done
    echo; echo
  done
}

# up 2 = cd ../../
upup(){ DEEP=$1; [ -z "${DEEP}" ] && { DEEP=1; }; for i in $(seq 1 ${DEEP}); do cd ../; done; }

# ex - archive extractor
# usage: ex <file>
ex ()
{
  if [ -f $1 ] ; then
    case $1 in
      *.tar.bz2)   tar xjf $1   ;;
      *.tar.gz)    tar xzf $1   ;;
      *.bz2)       bunzip2 $1   ;;
      *.rar)       unrar x $1     ;;
      *.gz)        gunzip $1    ;;
      *.tar)       tar xf $1    ;;
      *.tbz2)      tar xjf $1   ;;
      *.tgz)       tar xzf $1   ;;
      *.zip)       unzip $1     ;;
      *.Z)         uncompress $1;;
      *.7z)        7z x $1      ;;
      *)           echo "'$1' cannot be extracted via ex()" ;;
    esac
  else
    echo "'$1' is not a valid file"
  fi
}
#
# ----------------------------------------------------------------------------
# Docker Functions (thanks to https://github.com/geerlingguy)
# ----------------------------------------------------------------------------

# Enter a running Docker container.
function dockbash() {
  if [[ ! "$1" ]] ; then
    echo "You must supply a container ID or name."
    return 1
  fi

  docker exec -it $1 /bin/bash
  return 0
}

export -f dockbash

# Run docker container in detached and privileged mode
function dockrun() {
  docker run --detach --privileged "${1:-jam82/ubuntu1604}"
}

function dockrunbash() {
  dockrun | xargs -t -n1 -I{} bash -c "dockbash {}"
}

# Stop all running docker containers
function dstop() {
  docker ps | awk '{ print $1}' | grep -v CONTAINER | xargs docker stop
}

# Remove all local Docker images
function drmi() {
  docker images | awk '{ print $3 }' | grep -v IMAGE | xargs docker rmi -f
}

# ----------------------------------------------------------------------------
# Github Functions
# ----------------------------------------------------------------------------

function ghub-clone() {
  if [[ ! "$1" ]] ; then
    echo "You must supply a git repo."
    return 1
  fi
  
  git clone $GITHUB_SSH_URL$1.git
  return 0
}

function ghub-irap() {
  if [[ ! "$1" ]] ; then
    echo "You must supply a git repo."
    return 1
  fi

  git init && \
  git remote add origin $GITHUB_SSH_URL$1.git && \
  git push -u origin master
  return 0
}

function ghub-rap() {
  if [[ ! "$1" ]] ; then
    echo "You must supply a git repo."
    return 1
  fi

  git remote add origin $GITHUB_SSH_URL$1.git && \
  git push -u origin master
  return 0
}

# some security fixes
alias chown='chown --preserve-root'
alias chmod='chmod --preserve-root'
alias chgrp='chgrp --preserve-root'
# prevent remove, copy and move via regexp
alias rm='rm -I --preserve-root'
alias cp='cp -i'
alias mv='mv -i'
# create folders with subfolders automatically
alias mkdir='mkdir -pv'

# misc
alias more='less'
alias v='vim'
alias vi='vim'
alias svi='sudo vim'
alias h='history'
alias j='jobs -l'
alias which='type -a'
alias du='du -h'
alias df='df -Th'
alias mem='ps -eo pid,ppid,cmd,%mem,%cpu --sort=-%mem | head'
alias cpu='ps -eo pid,ppid,cmd,%mem,%cpu --sort=-%cpu | head'
alias sha3sum='sha3sum -a 512'
alias pipi='pip install --user'

alias up='upup' # nutzt Funktion upup()

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# GPG Master-Keys
alias gpg2-master='gpg2 --homedir="~/.gnupg-master"'

# Fun
alias cbsg='curl -s http://cbsg.sourceforge.net/cgi-bin/live | grep -Eo "^<li>.*</li>" | sed s,\</\\?li\>,,g | shuf -n 1'

# pretty print PATH
alias path='echo -e ${PATH//:/\\n}'
alias libpath='echo -e ${LD_LIBRARY_PATH//:/\\n}'

# directory navigation
alias cd..='cd ..'
alias ..='cd ..'

# time and date
alias now='date +"%T"'
alias nowdate='date +"%d.%m.%Y"'
alias fdate='date +"%Y%m%d"'
alias ftime='date +"%Y%m%d-%H%M%S"'

# ----------------------------------------------------------------------------
# color for ls, *grep
# ----------------------------------------------------------------------------

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
  test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
  LS_OPTIONS=" --color=auto"
  alias grep='grep --color=auto'
  alias fgrep='fgrep --color=auto'
  alias egrep='egrep --color=auto'
  alias diff='colordiff'
fi

# variable ls_options (ISO-Date)
alias ls="ls $LS_OPTIONS --time-style=long-iso"

alias l='ls -hl'
alias ll='ls -Ahl'
alias la='ls -ahl'
alias lt='ls -hltr'
alias lx='ls -hlXB'
alias lk='ls -hlSr'
alias lc='ls -hltcr'
alias lu='ls -hltur'

# ----------------------------------------------------------------------------
# System and update stuff
# ----------------------------------------------------------------------------

# if root, no sudo ...
if [ "$UID" -eq 0 ]; then
	pre_sudo=''
else
	pre_sudo='sudo'
fi

# install updates
alias au="${pre_sudo} pacman -Syu"
alias aus="PPWD=`pwd`; cd ~/src/ansible-dev/ && ansible-playbook main.yml --vault-password-file ~/.ansible-vault; cd $PPWD;"

# alias for apt-get
alias apt\-get="${pre_sudo} apt-get"

# show open ports with netstat
alias ports="${pre_sudo} netstat -tulanp"

unset pre_sudo
