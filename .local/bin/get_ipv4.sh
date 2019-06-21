#!/bin/bash -
if hash ip; then
    ip addr show  | sed -En 's/127.0.0.1//;s/.*inet (addr:)?(([0-9]*\.){3}[0-9]*).*/\2/p'
else
    echo -n 'n/a'
fi
