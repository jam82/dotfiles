#!/bin/bash -
if has mail; then
    mail --print | grep "From:" | wc -l
else
    echo -n 'n/a'
fi
