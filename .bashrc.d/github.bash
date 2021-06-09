# file: ~/.bashrc.d/github.bash

# ----------------------------------------------------------------------------
# Github Functions
# ----------------------------------------------------------------------------

gh-pr() {
  gh pr create --base ${2:-main} --head ${1:-dev} --title=${1} --body="${3:-}"
}

gh-clone() {
  if [[ ! "$1" ]] ; then
    echo "You must supply a github repo."
    return 1
  fi
  
  git clone "$GITHUB_SSH_URL$1.git"
  return 0
}

gh-ircap() {
  if [[ ! "$1" ]] ; then
    echo "You must supply a github repo."
    return 1
  fi

  git init && \
  git remote add origin "$GITHUB_SSH_URL$1.git" && \
  git add . && \
  git commit -m "first commit" && \
  git push -u origin main
  return 0
}

gh-rap() {
  if [[ ! "$1" ]] ; then
    echo "You must supply a github repo."
    return 1
  fi

  git remote add origin "$GITHUB_SSH_URL$1.git" && \
  git push -u origin main
  return 0
}
