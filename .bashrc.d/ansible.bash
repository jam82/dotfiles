# file: ~/.bashrc.d/ansible.bash

# ----------------------------------------------------------------------------
# Ansible Functions and Aliases
# ----------------------------------------------------------------------------

export ANSIBLE_INVENTORY=~/.ansible/hosts.yml
export ANSIBLE_ROLES_PATH=~/.ansible/roles

# check all debian based remote machines if reboot is required (rc=1 > reboot)
function ado-check-reboot() {
    ansible pkgman_apt -m shell \
        -a '[ ! -f /var/run/reboot-required ]'
}

# check for available updates
function ado-check-updates() {
    ansible pkgman_apt -m shell \
        -a "apt-get -u upgrade --assume-no | tail -n1" \
        -b
}

# reboot if required ($1=force reboots all, regardless if required)
function ado-reboot() {
    local ADO_CMD
    if [ -z "$1" ]; then
        ADO_CMD="[ -f /var/run/reboot-required ] && reboot"
    elif [ "$1" == "force" ]; then
        ADO_CMD="reboot"
    else
        echo "Aborted: Use parameter 'force' or nothing."
        return 0
    fi
    ansible pkgman_apt -m shell \
        -a "$ADO_CMD" \
        -b
}

# perform apt-get upgrade on all debian based remote machines
function ado-update() {
    ansible pkgman_apt -m apt \
        -a 'upgrade=yes' \
        -b
}

# perform apt-get upgrade on all debian based remote machines
function ado-upgrade() {
    ansible pkgman_apt -m apt \
        -a 'upgrade=yes update_cache=yes' \
        -b
}

# perform apt-get dist-upgrade on all debian based remote machines
function ado-dist-upgrade() {
    ansible pkgman_apt -m apt \
        -a 'upgrade=dist update_cache=yes' \
        -b
}
