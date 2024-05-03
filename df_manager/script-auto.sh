#!/bin/bash
# Lancement du playbook qui fait appel au role dockerhost qui lance la creation des conteneurs
# + Lance la copie des clees ssh entre les machines et lance le serveur ssh
ansible-playbook -i inventaire.ini --user root --private-key ansible-man-key deploy-lamp.yml
# Copie des clees ssh entre le manager et les hotes CTsite et CTbackup
sshpass -f rootpassword ssh-copy-id -i ansible-man-key.pub root@ctsite
sshpass -f rootpassword ssh-copy-id -i ansible-man-key.pub root@ctbackup
# Lancement du playbook qui permet de recuperer les backup (si elles existent) de CTbackup
# + Les transfert vers CTsite
ansible-playbook -i inventaire.ini --user root --private-key ansible-man-key recup-backup.yml
# Lancement du playbook qui fait appel au role lamp qui lance l'installation des paquets necessaire
# sur CTsite 
ansible-playbook -i inventaire.ini --user root --private-key ansible-man-key install-lamp.yml
