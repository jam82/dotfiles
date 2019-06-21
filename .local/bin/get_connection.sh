#!/bin/bash -
if [[ $SSH_CONNECTION ]]; then echo "from `echo $SSH_CONNECTION | cut -d ' ' -f1,2 | tr ' ' ':'`"; fi