# file ~/.bashrc.d/vars.bash

# Extend PATH
[ -d ~/.local/bin ] && export PATH=$PATH:~/.local/bin
[ -d ~/.gem/ruby/2.5.0/bin ] && export PATH=$PATH:~/.gem/ruby/2.5.0/bin
[ -d ~/.gem/ruby/2.6.0/bin ] && export PATH=$PATH:~/.gem/ruby/2.6.0/bin

# Use VIM
export EDITOR=vim
export VISUAL=$EDITOR
export HOSTNAME=$(hostname)

# Github.com
export GITHUB_USER=""
export GITHUB_TOKEN=""
export GITHUB_BASE_URL="github.com"
export GITHUB_SSH_URL="git@$GITHUB_BASE_URL:$GITHUB_USER/"
export GITHUB_HTTPS_URL="https://$GITHUB_BASE_URL/$GITHUB_USER/"

# Gitea
export GITEA_USER=""
export GITEA_TOKEN=""
export GITEA_BASE_URL=""
export GITEA_SSH_URL="git@$GITEA_BASE_URL:$GITEA_USER/"
export GITEA_HTTPS_URL="https://$GITEA_BASE_URL/$GITEA_USER/"
