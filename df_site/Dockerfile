FROM ubuntu

RUN echo 'root:R00tR00t502' | chpasswd
RUN apt update
RUN apt install -y nano net-tools iputils-ping openssh-server rsync sshpass
RUN echo "192.168.52.1    CTmanager" >> /root/tocat-hosts
RUN echo "192.168.52.3    CTbackup" >> /root/tocat-hosts
RUN echo "PermitRootLogin yes" >> /etc/ssh/sshd_config
RUN echo "    StrictHostKeyChecking no" >> /etc/ssh/ssh_config
COPY rootpassword /root/rootpassword
COPY site_db.conf /root/site_db.conf
COPY dir.conf /root/dir.conf
COPY index.php /root/index.php
RUN ssh-keygen -f /root/key-ansible -q -N ""

EXPOSE 80
