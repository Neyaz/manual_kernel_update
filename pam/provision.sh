#!/bin/bash
mkdir -p ~root/.ssh
cp ~vagrant/.ssh/auth* ~root/.ssh

yum install -y epel-release

sed -i 's/^PasswordAuthentication.*$/PasswordAuthentication yes/' /etc/ssh/sshd_config

cp /vagrant/sshd /etc/pam.d/sshd
cp /vagrant/pam_script.sh /etc/
chmod +x /etc/pam_script.sh
systemctl restart sshd.service

useradd user1
echo "12345678" | passwd user1 --stdin

useradd user2
echo "12345678" | passwd user2 --stdin

groupadd admin
usermod -a -G admin user1

echo "cap_sys_admin user1" > /etc/security/capability.conf
cp /vagrant/su /etc/pam.d/su
