#!/bin/bash - 
#===============================================================================
#
#          FILE: install.sh
# 
#         USAGE: ./install.sh 
# 
#   DESCRIPTION: creates symlinks in ~/ 
#                for all dotfiles in the local copy of the repo
# 
#       OPTIONS: ---
#  REQUIREMENTS: ---
#          BUGS: ---
#         NOTES: ---
#        AUTHOR: Jonas Mauer (jam82), jam@kabelmail.net
#  ORGANIZATION: 
#       CREATED: 13.06.2019 02:56:43
#      REVISION: ---
#===============================================================================

set -o nounset                              # Treat unset variables as an error

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

find $DIR -maxdepth 1 -type f -name ".*" \
    -not -name ".gitignore" -not -name ".bashrc_local" \
    -exec ln -sf {} ~/ \;

[ -f ~/.bashrc_local ] || cp $DIR/.bashrc_local ~/

mkdir -p ~/.screenrc.d && \
    chmod 700 ~/.screenrc.d && \
    chown $USER:$USER ~/.screenrc.d

mkdir -p ~/.local/bin && \
    chown $USER:$USER ~/.local/bin

find $DIR/.local/bin/ -maxdepth 1 -type f -name "*" \
    -exec ln -sf {} ~/.local/bin/ \;

chmod 700 ~/.local/bin/*

if [[ ! -L ~/.bashrc.d && ! -d ~/.bashrc.d ]]; then
    ln -sf $DIR/.bashrc.d ~/.bashrc.d && \
    chmod 700 ~/.bashrc.d && \
    chmod 600 ~/.bashrc.d/*
fi

if [[ ! -L ~/.bash_completion.d && ! -d ~/.bash_completion.d ]]; then
    ln -sf $DIR/.bash_completion.d ~/.bash_completion.d && \
    chmod 700 ~/.bash_completion.d && \
    chmod 600 ~/.bash_completion.d/*
fi
