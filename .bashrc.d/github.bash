# file: ~/.bashrc.d/github.bash

# ----------------------------------------------------------------------------
# Github Functions
# ----------------------------------------------------------------------------

function ghub-clone() {
  if [[ ! "$1" ]] ; then
    echo "You must supply a github repo."
    return 1
  fi
  
  git clone $GITHUB_SSH_URL$1.git
  return 0
}

function ghub-irap() {
  if [[ ! "$1" ]] ; then
    echo "You must supply a github repo."
    return 1
  fi

  git init && \
  git remote add origin $GITHUB_SSH_URL$1.git && \
  git push -u origin master
  return 0
}

function ghub-rap() {
  if [[ ! "$1" ]] ; then
    echo "You must supply a github repo."
    return 1
  fi

  git remote add origin $GITHUB_SSH_URL$1.git && \
  git push -u origin master
  return 0
}