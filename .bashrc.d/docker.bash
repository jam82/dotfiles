
# file: ~/.bashrc.d/docker.bash

# ----------------------------------------------------------------------------
# Docker Functions (thanks to https://github.com/geerlingguy for dbash)
# ----------------------------------------------------------------------------

# Enter a running Docker container.
function dbash() {
  if [[ ! "$1" ]] ; then
    echo "You must supply a container ID or name."
    return 1
  fi

  docker exec -it $1 /bin/bash
  return 0
}

# stop all containers and remove all images
function dkill() {
  dstop && drmi
}

# TODO: input is no tty
function drootbash() {
  drdp | xargs -t -n1 -I{} bash -c "dbash {}"
}

# Run docker container in detached and privileged mode
function drdp() {
  docker run --detach --privileged "${1:-jam82/ubuntu-molecule:1804}"
}

# Remove all local Docker images
function drmi() {
  docker images | awk '{ print $3 }' | grep -v IMAGE | xargs docker rmi -f
}

# Stop all running docker containers
function dstop() {
  docker ps | awk '{ print $1}' | grep -v CONTAINER | xargs docker stop
}
