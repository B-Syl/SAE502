#!/bin/bash
echo "docker build -t img_ctmanager df_manager"
docker build -t img_ctmanager df_manager
read -p "pause"
echo "docker build -t img_ctsite df_site"
docker build -t img_ctsite df_site
read -p "pause"
echo "docker build -t img_ctbackup df_backup"
docker build -t img_ctbackup df_backup
read -p "pause"
echo 'docker run -dti --name CTmanager --network net502 --ip="192.168.52.1" img_ctmanager /bin/bash'
docker run -dti --name CTmanager --network net502 --ip="192.168.52.1" img_ctmanager /bin/bash
read -p "pause"
echo "docker exec -ti CTmanager /bin/bash -c 'service ssh start'"
docker exec -ti CTmanager /bin/bash -c 'service ssh start'
echo "docker exec -ti CTmanager /bin/bash -c 'cat /root/tocat-hosts >> /etc/hosts'"
docker exec -ti CTmanager /bin/bash -c 'cat /root/tocat-hosts >> /etc/hosts'
read -p "pause"
echo "docker exec -u user-ansible -ti CTmanager /bin/bash -c 'cd && bash script-auto.sh'"
echo "Contenu script-auto.sh :"
cat df_manager/script-auto.sh | head -n 2
read -p "pause"
echo "deploy-lamp.yml => rôle dockerhost"
echo "tâche principale rôle dockerhost :"
cat df_manager/deploy-ct-docker.yml
read -p "pause"
echo "suite script-auto.sh"
cat df_manager/script-auto.sh | head -n 4 | tail -n 2
read -p "pause"
cat df_manager/script-auto.sh | tail -n 2 | head -n 1
read -p "pause"
echo "Contenu recup-backup.yml"
cat df_manager/recup-backup.yml
read -p "pause"
echo "suite script-auto.sh"
cat df_manager/script-auto.sh | tail -n 1
read -p "pause"
echo "install-lamp.yml => rôle lamp"
echo "tâche principale rôle lamp :"
cat df_manager/task-install-lamp.yml
read -p "pause"
echo "=============================="
echo "exécution script-auto.sh"

docker exec -u user-ansible -ti CTmanager /bin/bash -c 'cd && bash script-auto.sh'
read -p "pause"
echo "Reste la gestion des backup"
echo "fichier cron-backup ajouté à la création de l'image du CTmanager :"
cat df_manager/cron-backup
read -p "pause"

echo "contenu du playbook create-backup.yml :"
cat df_manager/create-backup.yml
read -p "FIN"
