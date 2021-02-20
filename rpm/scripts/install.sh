#!/bin/bash

mkdir -p ~root/.ssh
cp ~vagrant/.ssh/auth* ~root/.ssh

## Устаналиваем дополнительные пакеты
yum install -y \
        redhat-lsb-core \
        wget \
        rpmdevtools \
        rpm-build \
        createrepo \
        yum-utils \
        gcc

## Добавляем группу и пользователя builder, чтобы rpm не показывал warnings
groupadd -r builder && useradd -r -s /bin/false -g builder builder

## Качаем nginx
wget https://nginx.org/packages/centos/7/SRPMS/nginx-1.14.1-1.el7_4.ngx.src.rpm

## Распаковываем исходники
rpm -i nginx-1.14.1-1.el7_4.ngx.src.rpm

## Скачиваем openssl и распаковываем
wget https://www.openssl.org/source/latest.tar.gz
tar -xvf latest.tar.gz
mv openssl-1.1.1j /root/openssl-1.1.1j

## Указываем путь до openssl
sed -i 's/--with-debug/--with-openssl=\/root\/openssl-1.1.1j/g' /root/rpmbuild/SPECS/nginx.spec

## Устаналиваем зависимости
yum-builddep -y /root/rpmbuild/SPECS/nginx.spec

## Собираем пакет
rpmbuild -bb /root/rpmbuild/SPECS/nginx.spec

## Устаналиваем nginx из пакета и стартуем
yum localinstall -y \
/root/rpmbuild/RPMS/x86_64/nginx-1.14.1-1.el7_4.ngx.x86_64.rpm
systemctl start nginx

## Создаем репозиторий и копируем туда наш пакет с nginx, а так же качаем дополнительный пакет
mkdir /usr/share/nginx/html/repo
cp /root/rpmbuild/RPMS/x86_64/nginx-1.14.1-1.el7_4.ngx.x86_64.rpm /usr/share/nginx/html/repo/
wget https://downloads.percona.com/downloads/percona-release/percona-release-1.0-9/redhat/percona-release-1.0-9.noarch.rpm -O /usr/share/nginx/html/repo/percona-release-1.0-9.noarch.rpm
createrepo /usr/share/nginx/html/repo/
createrepo --update /usr/share/nginx/html/repo/

## Добавляем autoindex в конфиги nginx
sed -i '/index.htm;/a \\t autoindex on;' /etc/nginx/conf.d/default.conf
nginx -s reload

## Создаем конфиг репозитория
cat >> /etc/yum.repos.d/otus.repo << EOF
[otus]
name=otus-linux
baseurl=http://localhost/repo
gpgcheck=0
enabled=1
EOF
yum clean all
