#!/bin/bash

function makeFileWithMode {
    [[ -f $1 ]] || (touch $1 ; chmod $2 $1)
}

# ensure SSH is running and enabled
sudo systemctl status ssh | grep -q "Active: active" || sudo systemctl start ssh
sudo systemctl status ssh | grep Loaded: | grep -q "ssh.service; enabled" || sudo systemctl enable ssh

# generate SSH keys for pi user if missing
[[ -f /home/pi/.ssh/id_rsa ]] || (echo -e "\n\n\n" | ssh-keygen 2>&1 >/dev/null)

# authorize the Pi's own key
ak="/home/pi/.ssh/authorized_keys"
makeFileWithMode $ak 600
grep -q "$(cat /home/pi/.ssh/id_rsa.pub)" $ak || (cat /home/pi/.ssh/id_rsa.pub >> $ak)

# ensure localhost is in known_hosts
kh="/home/pi/.ssh/known_hosts"
makeFileWithMode $kh 600
grep -q localhost $kh || ssh-keyscan localhost >>$kh

# install Ansible
sudo dpkg -s ansible 2>&1 >/dev/null || sudo apt-get install -y ansible

ansible-playbook site.yml -i hosts-localhost -u pi
