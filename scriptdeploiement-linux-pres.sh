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

docker exec -u user-ansible -ti CTmanager /bin/bash -c 'cd && bash script-auto.sh'
