# file: ~/.bashrc.d/github.bash

# ----------------------------------------------------------------------------
# Github Functions
# ----------------------------------------------------------------------------

gh-pr() {
  gh pr create --base ${2:-main} --head ${1:-dev} --title=${1:-dev} --body="${3:-}"
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

gh-push-roles() {
  shopt -s nullglob
  for role in ansible-role-*
  do
    cd $role
    if $(git ls-remote origin 2>&1 1>/dev/null) 2>/dev/null; then
        git add . 1>/dev/null
        git commit -m "${1:-update}" 1>/dev/null
        git push 1>/dev/null
        echo "pushed $role to github.com ..."
    else
        echo "omitted $role"
    fi
    cd ..
  done
  shopt -u nullglob
}
