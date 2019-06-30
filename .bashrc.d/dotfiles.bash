# file: ~/.bashrc.d/dotfiles.bash

# ----------------------------------------------------------------------------
# dotfile Functions and Aliases
# ----------------------------------------------------------------------------

DOT_PATH=$HOME/.dotfiles
DOT_GIT=$DOT_PATH/.git

alias dotfiles="/usr/bin/git --git-dir=$DOT_GIT --work-tree=$DOT_PATH/"

# update
function dotfiles-update() {
    dotfiles pull
    source ~/.bashrc
}

# update all including remotes
function dotfiles-update-all() {
    dotfiles-update
    ansible pkgman_apt -m shell -a "cd .dotfiles && git pull"
}

# commit and push
function dotfiles-cap() {
    dotfiles add .
    dotfiles commit
    dotfiles push
}
