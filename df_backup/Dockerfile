FROM ubuntu

RUN echo 'root:R00tR00t502' | chpasswd
RUN apt update
RUN apt install -y nano net-tools iputils-ping openssh-server
RUN echo "192.168.52.1    CTmanager" >> /root/tocat-hosts
RUN echo "192.168.52.2    CTsite" >> /root/tocat-hosts
RUN echo "PermitRootLogin yes" >> /etc/ssh/sshd_config
RUN echo "    StrictHostKeyChecking no" >> /etc/ssh/ssh_config
COPY rootpassword /root/rootpassword
RUN ssh-keygen -f /root/key-ansible -q -N ""
