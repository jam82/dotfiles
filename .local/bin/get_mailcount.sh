#!/bin/bash -
if hash mail; then
    mail --print | grep "From:" | wc -l
else
    echo -n 'n/a'
fi
