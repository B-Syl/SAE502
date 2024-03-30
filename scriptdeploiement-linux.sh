#!/bin/bash
docker build -t img_ctmanager df_manager
docker build -t img_ctsite df_site
docker build -t img_ctbackup df_backup
docker run -dti --name CTmanager --network net502 --ip="192.168.52.1" img_ctmanager /bin/bash
docker exec -ti CTmanager /bin/bash -c 'service ssh start'
docker exec -ti CTmanager /bin/bash -c 'cat /root/tocat-hosts >> /etc/hosts'