#!/bin/bash
############################
echo -e  "######\e[1;92m Starting ---- Samba ---- Configuration \e[0m######"
dt=$(date +%d-%b-%Y)
# Add Users for samba access
echo -e  "######\e[96m Add Users for samba access \e[0m######"
sleep 2
useradd -r smbu1 
useradd -r smbu2 
useradd -r smbu3 
sleep 2
(echo "12345";echo "12345")|smbpasswd -a smbu1
sleep 2
(echo "smbu2";echo "smbu2")|smbpasswd -a smbu2
sleep 2
(echo "smbu3";echo "smbu3")|smbpasswd -a smbu3
sleep 2
groupadd smbgrp
usermod -aG smbgrp smbu2
sleep 2
usermod -aG smbgrp smbu3
sleep 2
# Creating Directories for Samba Share
echo -e  "######\e[96m Creating Directories for Samba Share \e[0m######"
mkdir -p /DatA/{ISO,Share,Users}
sleep 2
chmod -R 777 /DatA
sleep 2
# If file "smb.conf" exist in /etc/samba directory ,then take a backup
echo -e  "######\e[96m Backup smb.conf \e[0m######"
[ -f /etc/samba/smb.conf ] && cp /etc/samba/smb.conf /etc/samba/smb.conf-$dt
sleep 2
# If file smb.conf exist in current working directory ,then copy its contents to "/etc/samba/smb.conf"
echo -e  "######\e[96m Adding smb.conf \e[0m######"
[ -f smb.conf ] && cat smb.conf > /etc/samba/smb.conf
sleep 2
# Starting samba , if directory "/etc/systemd" exist
echo -e  "######\e[96m Starting samba \e[0m######"
sleep 2
testparm
[ -d /etc/systemd ] && systemctl restart smbd && systemctl enable smbd
sleep 2
echo -e  "######\e[1;92m Samba ---- Configuration ---- Completed \e[0m######"
read -rsp $'\e[1;97;45m     ...Press any key to Exit...   \e[0m\n' -n1 key
############################

