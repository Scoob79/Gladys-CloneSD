#!/bin/bash
DATE=$(date +"%Y-%m-%d")
BoxToClone=Mia
SdImgSize=2032664576
FileName=SD-Backup_$BoxToClone\_$DATE.img
File=/mnt/NAS_BOX/$FileName

sudo mount -v -t cifs //192.168.1.2/Disque\ dur\ LaBox /mnt/NAS_BOX -o user=admin,pass=password,rw,uid=1000,gid=1000
#sudo dd if=/dev/mmcblk0 bs=4M of=$File && sync
sudo dd if=/dev/mmcblk0 bs=4M | sudo gzip -1 -| sudo dd of=$File && sync

FileStat=$(wc -c "$File" | cut -f 1 -d ' ')
