# file: ~/.bashrc.d/ansible.bash

# ----------------------------------------------------------------------------
# Ansible Functions and Aliases
# ----------------------------------------------------------------------------

# ansible-galaxy init with custom role skeleton
function aga-init() {
    if [ -z "$1" ]; then
    echo "Please specify a role name that will be appended to ansible-role-<rolename>"
    return 1
    fi
    ansible-galaxy init --role-skeleton=${2:-'./ansible-skeleton'} ansible-role-$1
}

# check all debian based remote machines if reboot is required (rc=1 > reboot)
function ado-check-reboot() {
    ansible ${1:-pkgman_apt} -m shell \
        -a '[ ! -f /var/run/reboot-required ]'
}

# check for available updates
function ado-check-updates() {
    ansible ${1:-pkgman_apt} -m shell \
        -a "apt-get -u upgrade --assume-no | tail -n1" \
        -b
}

# reboot if required ($1=force reboots all, regardless if required)
function ado-reboot() {
    local ADO_CMD
    if [ -z "$2" ]; then
        ADO_CMD="[ -f /var/run/reboot-required ] && reboot"
    elif [ "$2" == "force" ]; then
        ADO_CMD="reboot"
    else
        echo "Aborted: Use parameter 'force' or nothing."
        return 0
    fi
    ansible ${1:-pkgman_apt} -m shell \
        -a "$ADO_CMD" \
        -b
}

# update apt cache on all debian based remote machines
function ado-apt-update() {
    ansible ${1:-pkgman_apt} -m apt \
        -a 'update_cache=yes' \
        -b
}

# perform apt-get upgrade on all debian based remote machines
function ado-apt-upgrade() {
    ansible ${1:-pkgman_apt} -m apt \
        -a 'upgrade=yes update_cache=yes' \
        -b
}

# perform apt-get dist-upgrade on all debian based remote machines
function ado-apt-dist-upgrade() {
    ansible ${1:-pkgman_apt} -m apt \
        -a 'upgrade=dist update_cache=yes' \
        -b
}
