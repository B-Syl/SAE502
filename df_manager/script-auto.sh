#!/bin/bash
ansible-playbook -i inventaire.ini --user root --private-key ansible-man-key deploy-lamp.yml
sshpass -f rootpassword ssh-copy-id -i ansible-man-key.pub root@ctsite
sshpass -f rootpassword ssh-copy-id -i ansible-man-key.pub root@ctbackup
ansible-playbook -i inventaire.ini --user root --private-key ansible-man-key recup-backup.yml
ansible-playbook -i inventaire.ini --user root --private-key ansible-man-key install-lamp.yml
