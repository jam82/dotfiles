# file: ~/.bashrc.d/aliases.bash

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

# secret-tool
alias sec='secret-tool'

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
