#!/bin/bash

## Копируем файлы

WATCHLOG_DATA_PATH=/vagrant/watchlog
chmod +x $WATCHLOG_DATA_PATH/watchlog.sh

mv $WATCHLOG_DATA_PATH/watchlog /etc/sysconfig/
mv $WATCHLOG_DATA_PATH/watchlog.log  /var/log/
mv $WATCHLOG_DATA_PATH/watchlog.sh /opt/
mv $WATCHLOG_DATA_PATH/watchlog.service /etc/systemd/system/
mv $WATCHLOG_DATA_PATH/watchlog.timer /etc/systemd/system/

## Запускаем сервис

sudo systemctl enable watchlog.timer
sudo systemctl start watchlog.timer
sudo systemctl enable watchlog.service
sudo systemctl start watchlog.service
