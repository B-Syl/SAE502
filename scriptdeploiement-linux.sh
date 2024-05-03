#!/bin/bash
# Creation des images pour le CTmanager, CTsite et CTbackup
docker build -t img_ctmanager df_manager
docker build -t img_ctsite df_site
docker build -t img_ctbackup df_backup
# Creation du conteneur CTmanager avec l'image cree precedemment
docker run -dti --name CTmanager --network net502 --ip="192.168.52.1" img_ctmanager /bin/bash
# Demarrage du serveur ssh
docker exec -ti CTmanager /bin/bash -c 'service ssh start'
# Ajout des hotes dans le fichier hosts pour la resolution DNS
docker exec -ti CTmanager /bin/bash -c 'cat /root/tocat-hosts >> /etc/hosts'
# Lancement du script qui lance les playbook automatique
docker exec -u user-ansible -ti CTmanager /bin/bash -c 'cd && bash script-auto.sh'
# Demarrage du service cron pour permettre le lancement de sauvegarde automatique
docker exec -ti CTmanager /bin/bash -c '/usr/sbin/cron start'

