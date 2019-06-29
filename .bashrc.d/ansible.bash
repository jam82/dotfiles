# file: ~/.bashrc.d/ansible.bash

# ----------------------------------------------------------------------------
# Ansible Functions and Aliases
# ----------------------------------------------------------------------------

export ANSIBLE_INVENTORY=~/.ansible/hosts.yml
export ANSIBLE_ROLES_PATH=~/.ansible/roles
export ANSIBLE_VAULT=~/.ansible/.vault

# perform apt-get dist-upgrade on all debian based remote machines
alias ado-update="ansible debian -m apt -a 'upgrade=yes update_cache=yes' -b"

# check all debian based remote machines if reboot is required (rc=1 > reboot)
function ado-check-reboot() {
    ansible debian -m shell -a '[ ! -f /var/run/reboot-required ]'
}

# reboot if required ($1=force reboots all, regardless if required)
function ado-reboot() {
    local ADO_CMD
    if [ -z $1 ]; then
        ADO_CMD="[ -f /var/run/reboot-required ] && reboot"
    elif [ $1 == "force" ]; then
        ADO_CMD="reboot"
    else
        echo "Aborted: Use parameter 'force' or nothing."
        return 0
    fi
    ansible debian -m shell -a $ADO_CMD -b
}