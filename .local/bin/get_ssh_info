#!/bin/bash - 
#===============================================================================
#
#          FILE: get_ssh_info.sh
# 
#         USAGE: ./get_ssh_info.sh 
# 
#   DESCRIPTION: 
# 
#       OPTIONS: ---
#  REQUIREMENTS: ---
#          BUGS: ---
#         NOTES: ---
#        AUTHOR: Jonas Mauer (jam82), jam@kabelmail.net
#  ORGANIZATION: -
#       CREATED: 21.06.2019 02:28:02
#      REVISION:  ---
#===============================================================================

set -o nounset                              # Treat unset variables as an error

for type in {cipher,kex,key,mac} ; \
  do for entry in `ssh -Q $type` ; \
    do echo "`ssh -V 2>&1 | \
      sed -r "s/.*_([0-9.]*).*\s{1}.*/\1/"`;$type;$entry" ; \
    done ; \
  done

