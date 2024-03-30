docker build --no-cache -t img_ctmanager df_manager
docker build --no-cache -t img_ctsite df_site
docker run -dti --name CTmanager --network net502 --ip="192.168.52.1" img_ctmanager /bin/bash
docker exec -ti CTmanager service ssh start
docker exec -ti CTmanager cat /root/tocat-hosts >> /etc/hosts