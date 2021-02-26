#!/bin/bash

mkdir -p ~root/.ssh
cp ~vagrant/.ssh/auth* ~root/.ssh

yum install nfs-utils -y

systemctl start firewalld

echo "192.168.50.10:/var/share /mnt  nfs vers=3,proto=udp,noexec,nosuid 0 0" >> /etc/fstab

mount -a
