#!/bin/bash
docker exec -u user-ansible -ti CTmanager /bin/bash -c 'ansible-playbook -i /home/user-ansible/inventaire.ini --user root --private-key /home/user-ansible/ansible-man-key /home/user-ansible/create-backup.yml'
