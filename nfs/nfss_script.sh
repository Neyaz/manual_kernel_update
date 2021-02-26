#!/bin/bash

mkdir -p ~root/.ssh
cp ~vagrant/.ssh/auth* ~root/.ssh

yum install rpcbind nfs-utils -y

## Включаем сервисы NFS
for service in {rpcbind,nfs-server,nfs-lock,nfs-idmap}; do
  systemctl enable $service
done

## Запускаем фаерволл
systemctl start firewalld

## Создаем директорию, которую будем расшаривать.
mkdir -p /var/share/upload
chmod 777 /var/share/upload

## Конфигурируем NFS
echo "/var/share *(rw,sync,all_squash,no_subtree_check)" > /etc/exports

## Конфигурируем фаервол
for service in {nfs,mountd,rpc-bind}; do
  firewall-cmd --permanent --zone=public --add-service=$service
done
for port in {111,54302,20048,2049,46666,42955,875}; do
  firewall-cmd --permanent --add-port=$port/udp
done
firewall-cmd --reload

## Запускаем сервисы NFS
for service in {rpcbind,nfs-server,nfs-lock,nfs-idmap}; do
  systemctl start $service
done
