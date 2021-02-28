#!/bin/bash

## Копируем файлы

HTTPD_CONFIGS_PATH=/vagrant/httpd
cp $HTTPD_CONFIGS_PATH/httpd@.service /etc/systemd/system/
cp $HTTPD_CONFIGS_PATH/httpd-1 /etc/sysconfig/
cp $HTTPD_CONFIGS_PATH/httpd-2 /etc/sysconfig/
cp $HTTPD_CONFIGS_PATH/httpd-1.conf /etc/httpd/conf/
cp $HTTPD_CONFIGS_PATH/httpd-2.conf /etc/httpd/conf/

# Запускаем сервисы

sudo systemctl daemon-reload
sudo systemctl start httpd@1
sudo systemctl start httpd@2
