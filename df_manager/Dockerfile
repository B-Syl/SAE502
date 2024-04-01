FROM ubuntu

ARG user=user-ansible
ARG group=user-ansible
ARG uid=1000
ARG gid=1000
RUN echo 'root:R00tR00t502' | chpasswd
RUN groupadd -g ${gid} ${group}
RUN useradd -u ${uid} -g ${group} -s /bin/bash -m ${user}
RUN apt update
RUN apt install -y nano net-tools iputils-ping python3-virtualenv openssh-server sshpass tree
RUN echo "192.168.52.2    CTsite" >> /root/tocat-hosts
RUN echo "192.168.52.3    CTbackup" >> /root/tocat-hosts
RUN echo "192.168.52.254  Dockerhost" >> /root/tocat-hosts
RUN echo "PermitRootLogin yes" >> /etc/ssh/sshd_config
RUN echo "    StrictHostKeyChecking no" >> /etc/ssh/ssh_config
RUN pip install ansible
COPY --chown=${user}:${group} script-auto.sh /home/${user}/script-auto.sh
COPY --chown=${user}:${group} inventaire.ini /home/${user}/inventaire.ini
COPY --chown=${user}:${group} rootpassword /home/${user}/rootpassword
COPY --chown=${user}:${group} deploy-ct-lamp.yml /home/${user}/deploy-lamp.yml
COPY --chown=${user}:${group} deploy-ct-docker.yml /home/${user}/roles/dockerhost/tasks/main.yml
COPY --chown=${user}:${group} install-lamp.yml /home/${user}/install-lamp.yml
COPY --chown=${user}:${group} task-install-lamp.yml /home/${user}/roles/lamp/tasks/main.yml
COPY --chown=${user}:${group} recup-backup.yml /home/${user}/recup-backup.yml
COPY --chown=${user}:${group} create-backup.yml /home/${user}/create-backup.yml
#enfin "COPY <playbook> /home/${user}/<dest>" pour chaque playbooks et rôles
USER ${user}
RUN cd && virtualenv ansible
RUN mkdir /home/${user}/.ssh
RUN ssh-keygen -f /home/${user}/ansible-man-key -q -N ""
RUN sshpass -f /home/${user}/rootpassword ssh-copy-id -i /home/${user}/ansible-man-key.pub root@192.168.52.254
USER root

EXPOSE 22
