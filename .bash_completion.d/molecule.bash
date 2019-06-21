# file: ~/.bash_completion.d/molecule.bash

if hash molecule 2>/dev/null; then
    eval "$(_MOLECULE_COMPLETE=source molecule)"
fi
