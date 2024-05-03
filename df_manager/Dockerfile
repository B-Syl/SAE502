# Utilisation de la dernière image d'ubuntu
FROM ubuntu

# Déclaration des variables user et group sur user-ansible
ARG user=user-ansible
ARG group=user-ansible

# Déclaration des variables de userid et groupid
ARG uid=1000
ARG gid=1000

# Création d'un mot de passe pour l'utilisateur root
RUN echo 'root:R00tR00t502' | chpasswd

# Création du groupe et de l'utilisateur user-ansible qui s'occupera d'exécuter les playbook ansible
RUN groupadd -g ${gid} ${group}
RUN useradd -u ${uid} -g ${group} -s /bin/bash -m ${user}

# Installation de tous les paquets nécessaire à CTmanager
RUN apt update
RUN apt install -y nano net-tools iputils-ping python3-virtualenv openssh-server sshpass tree cron

# Création d'un fichier qui contient les noms d'hôtes et leurs adresses IP pour la résolution DNS
RUN echo "192.168.52.2    CTsite" >> /root/tocat-hosts
RUN echo "192.168.52.3    CTbackup" >> /root/tocat-hosts
RUN echo "192.168.52.254  Dockerhost" >> /root/tocat-hosts

# Ajout de paramètres dans les fichiers de configurations SSH
# Le premier paramètre permet de se connecter à la machine actuelle sur l'utilisateur root
# Le deuxième permet d'éviter d'avoir une vérification du fingerprint du serveur distant lorsqu'on se connecte depuis cette machine
RUN echo "PermitRootLogin yes" >> /etc/ssh/sshd_config
RUN echo "    StrictHostKeyChecking no" >> /etc/ssh/ssh_config

# Installation d'ansible avec pip
RUN pip install ansible

# Copie de tout les fichiers nécessaires au bon fonctionnement de notre infrastructure
# Ajout de l'option chown qui donne la propriété des fichiers à user-ansible comme c'est cet utilisateur qui exécutera tout les scripts/playbooks

# script-auto.sh permet lance le reste du deploiement une fois que CTmanager est entierement déployer
COPY --chown=${user}:${group} script-auto.sh /home/${user}/script-auto.sh

# inventaire.ini contient les hôtes sur lesquels les playbooks vont intervenir
COPY --chown=${user}:${group} inventaire.ini /home/${user}/inventaire.ini

# rootpassword contient le mot de passe de root (identique pour chaque machine), utilisé par sshpass pour éviter de retrouver le mdp dans history
COPY --chown=${user}:${group} rootpassword /home/${user}/rootpassword

# deploy-lamp.yml fait appel au rôle dockerhost qui lance sa tâche principale (main.yml ci-dessous)
COPY --chown=${user}:${group} deploy-ct-lamp.yml /home/${user}/deploy-lamp.yml
COPY --chown=${user}:${group} deploy-ct-docker.yml /home/${user}/roles/dockerhost/tasks/main.yml

# install-lamp.yml fait appel au rôle lamp qui lance sa tâche principale (main.yml ci-dessous)
COPY --chown=${user}:${group} install-lamp.yml /home/${user}/install-lamp.yml
COPY --chown=${user}:${group} task-install-lamp.yml /home/${user}/roles/lamp/tasks/main.yml

# recup-backup.yml récupère la base de données sauvegardé sur la machine CTbackup pour la transféré vers CTsite
COPY --chown=${user}:${group} recup-backup.yml /home/${user}/recup-backup.yml

# create-backup.yml fait la même chose que ci-dessus mais dans l'autre sens
COPY --chown=${user}:${group} create-backup.yml /home/${user}/create-backup.yml

# cron-backup contient le fichier de référence cron (plus de détails dans le commentaire du fichier)
COPY --chown=${user}:${group} cron-backup /home/${user}/cron-backup

# Changement d'utilisateur dans le Dockerfile
USER ${user}

# Création de l'environnement virtuel du nom d'ansible
RUN cd && virtualenv ansible

# Création du répertoire .ssh pour permettre la récupération de clée SSH
RUN mkdir /home/${user}/.ssh

# Génération d'une clée SSH avec des option empêchant le besoin d'une intervention humaine + Envoi de la clée à la machine mère
RUN ssh-keygen -f /home/${user}/ansible-man-key -q -N ""
RUN sshpass -f /home/${user}/rootpassword ssh-copy-id -i /home/${user}/ansible-man-key.pub root@192.168.52.254

# Attribution du fichier cron-backup au crontab de l'utilisateur user-ansible
RUN crontab /home/user-ansible/cron-backup

# Retour sur l'utilisateur root 
USER root

# Lancement du service cron à chaque démarrage du conteneur
CMD /usr/sbin/cron start

# Exposition du port 22 si on veut se connecter en SSH au conteneur depuis la machine mère
EXPOSE 22
