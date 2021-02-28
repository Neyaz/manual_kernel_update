#!/bin/bash

sudo sed -i 's/#SOCKET/SOCKET/' /etc/sysconfig/spawn-fcgi
sudo sed -i 's/#OPTIONS/OPTIONS/' /etc/sysconfig/spawn-fcgi

FCGI_SERVICE_PATH=/vagrant/fcgi
mv $FCGI_SERVICE_PATH/spawn-fcgi.service /etc/systemd/system/

sudo systemctl daemon-reload

sudo systemctl enabled spawn-fcgi
sudo systemctl start spawn-fcgi
