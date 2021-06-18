# file: ~/.bashrc.d/git.bash

# ----------------------------------------------------------------------------
# Git Functions
# ----------------------------------------------------------------------------

git-cap() {
    git add .
    git commit
    git push
}

git-d2m() {
    git checkout main
    git pull
    git merge dev
    git push -u origin main
    git checkout dev
}
