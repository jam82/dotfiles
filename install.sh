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
    -not -name ".gitignore" -exec ln -sf {} ~/ \;

mkdir -p ~/.screenrc.d && \
    chmod 700 ~/.screenrc.d && \
    chown $USER:$USER ~/.screenrc.d

mkdir -p ~/.local/bin && \
    chmod 700 ~/.local/bin/* && \
    chown $USER:$USER ~/.local/bin

find $DIR/.local/bin/ -maxdepth 1 -type f -name ".*" \
    -exec ln -sf {} ~/.local/bin/ \;

mkdir -p ~/.bashrc.d && \
    chmod 600 ~/.bashrc.d/* && \
    chown $USER:$USER ~/.bashrc.d

find $DIR/.bashrc.d/ -maxdepth 1 -type f -name "*.bash" \
    -exec ln -sf {} ~/.bashrc.d/ \;

mkdir -p ~/.bash_completion.d && \
    chmod 600 $DIR/.bash_completion.d/* && \
    chown $USER:$USER ~/.bash_completion.d

find $DIR/.bash_completion.d/ -maxdepth 1 -type f -name "*.bash" \
    -exec ln -sf {} ~/.bash_completion.d/ \;
