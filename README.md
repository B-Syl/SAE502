Déploiement projet requiert docker et docker builder

Déploiement du projet :

LINUX : 
  - Lancer le script "scriptdeploiement-linux.sh" avec la commande bash
    - root@machine:~/repo-git# bash scriptdeploiement-linux.sh

WINDOWS :
  - Lancer le script "scriptdeploiement-windows.ps1" sur powershell
  - Attention : Script non testé

Page web site accessible depuis l'adresse de la machine qui héberge le conteneur de site (HTTP + port 80)


Identifiants MySQL :

- User : db_user
- Password : password

BDD : 
- Nom base :  db_site_test
- Table : COLTEST
