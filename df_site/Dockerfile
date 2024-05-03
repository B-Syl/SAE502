FROM ubuntu

# Création d'un mot de passe pour root
RUN echo 'root:R00tR00t502' | chpasswd

# Installation de paquet essentiels, ce qu'il manque (PHP, Apache2, MySQL, etc...) sera rajouté grâce à Ansible
RUN apt update
RUN apt install -y nano net-tools iputils-ping openssh-server rsync sshpass

# Création d'un fichier qui contient les hôtes avec laquelle la machine interagira (inutilisé)
RUN echo "192.168.52.1    CTmanager" >> /root/tocat-hosts
RUN echo "192.168.52.3    CTbackup" >> /root/tocat-hosts

# Ajout de paramètres comme pour CTmanager qui permet de se connecter en SSH à cette machine avec l'utilisateur root
# Et l'autre paramètre qui évite la vérification des serveurs auxquelles on se connecte
RUN echo "PermitRootLogin yes" >> /etc/ssh/sshd_config
RUN echo "    StrictHostKeyChecking no" >> /etc/ssh/ssh_config

# Copie de fichiers vers le conteneurs
COPY rootpassword /root/rootpassword
COPY site_db.conf /root/site_db.conf
COPY dir.conf /root/dir.conf
COPY index.php /root/index.php

# Génération d'une clée SSH qui sera copié plus tard vers CTbackup
RUN ssh-keygen -f /root/key-ansible -q -N ""

# Exposition du port 80 pour accéder au serveur web depuis un navigateur
EXPOSE 80
