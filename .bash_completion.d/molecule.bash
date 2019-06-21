# file: ~/.bash_completion.d/molecule.bash

if has molecule; then
    eval "$(_MOLECULE_COMPLETE=source molecule)"
fi
