#!/bin/bash - 
#===============================================================================
#
#          FILE: get_ssh_config_hosts.sh
# 
#         USAGE: ./get_ssh_config_hosts.sh 
# 
#   DESCRIPTION: 
# 
#       OPTIONS: ---
#  REQUIREMENTS: ---
#          BUGS: ---
#         NOTES: ---
#        AUTHOR: Jonas Mauer (jam82), jam@kabelmail.net
#  ORGANIZATION: -
#       CREATED: 21.06.2019 02:30:18
#      REVISION:  ---
#===============================================================================

set -o nounset                              # Treat unset variables as an error

cat .ssh/config | grep "Host " | sed -r "s/Host ([a-zA-z0-9])/\1/"

