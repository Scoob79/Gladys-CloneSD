# Gladys-CloneSD

Ce complément de Gladys Project permet de cloner et stocker sur un partage réseau votre sauvegarde SD. 

Pour l'installation rien de plus simple :

1 - positionnez-vous dans le répertoire où vous souhaitez 
2 - git clone https://github.com/Scoob79/Gladys-CloneSD.git
3 - le rendre exécutable sudo chmod +x ./CloneSD.sh
4 - créer le point de montage avec la commande sudo mkdir /mnt/NAS_BOX 

c'est tout !!!

Pour le paramètrage tout aussi simple :

1 - Editer le script en utilisant la commande sudo nano ./CloneSD.sh

#!/bin/bash
DATE=$(date +"%Y-%m-%d")
BoxToClone=MiaSd
ImgSize=2032664576
FileName=SD-Backup_$BoxToClone\_$DATE.img
File=/mnt/NAS_BOX/$FileName

sudo mount -v -t cifs //192.168.1.2/partage /mnt/NAS_BOX -o user=admin,pass=password,rw,uid=1000,gid=1000
#sudo dd if=/dev/mmcblk0 bs=4M of=$File && sync
sudo dd if=/dev/mmcblk0 bs=4M | sudo gzip -1 -| sudo dd of=$File && sync

FileStat=$(wc -c "$File" | cut -f 1 -d ' ')

2 - sur la ligne //192.168.1.2/partage /mnt/NAS_BOX -o user=admin,pass=password
                 |                   | |          |         |   |      |      |
                 --------------------- ------------         -----      --------
                            |                |                |           |______> mot de passe d'accès au partage
                            |                |                |__________________> compte d'accès
                            |                |___________________________________> point de montage créé plus haut
                            |____________________________________________________> partage distant

3 - Ces deux lignes vous permette d'activer ou pas la compression de données
#sudo dd if=/dev/mmcblk0 bs=4M of=$File && sync                             Sans 
sudo dd if=/dev/mmcblk0 bs=4M | sudo gzip -1 -| sudo dd of=$File && sync    Avec 

Et pour l'utiliser :

1 - positionnez-vous dans le répertoire où vous l'avez installé
2 - sudo ./CloneSD.sh
3 - Automatisation :

# Ajouter cette ligne dans cron avec la commande sudo crontab -e
# 0 0 * * * /home/pi/module/glady-backup/CloneSD.sh
