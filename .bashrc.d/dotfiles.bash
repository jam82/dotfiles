# file: ~/.bashrc.d/dotfiles.bash

# ----------------------------------------------------------------------------
# dotfile Functions and ALiases
# ----------------------------------------------------------------------------

DOT_PATH=$HOME/.dotfiles
DOT_GIT=$DOT_PATH/.git

alias dotfiles="/usr/bin/git --git-dir=$DOT_GIT --work-tree=$DOT_PATH/"

function dotfiles-update() {
    dotfiles pull
    source ~/.bashrc
}

function dotfiles-push() {
    dotfiles add .
    dotfiles commit
    dotfiles push
}
