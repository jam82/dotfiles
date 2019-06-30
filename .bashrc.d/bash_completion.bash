# file: ~/.bashrc.d/bash_completion.bash

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

# source tool specific completions

if hash kubectl 2>/dev/null; then
    source <(kubectl completion bash)
fi

if hash molecule 2>/dev/null; then
    eval "$(_MOLECULE_COMPLETE=source molecule)"
fi

complete -cf sudo
