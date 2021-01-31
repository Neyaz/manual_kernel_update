#!/bin/bash

# Install developer tools
yum group install -y "Development Tools"
yum install -y ncurses-devel bison flex elfutils-libelf-devel openssl-devel wget bc

# Update gcc
yum install -y yum-utils centos-release-scl
yum -y --enablerepo=centos-sclo-rh-testing install devtoolset-7-gcc
echo "source /opt/rh/devtoolset-7/enable" | sudo tee -a /etc/profile
source /opt/rh/devtoolset-7/enable

# Download kernel sources
wget https://cdn.kernel.org/pub/linux/kernel/v5.x/linux-5.10.11.tar.xz

# Unzip sources
unxz -v linux*
tar xvf linux*

# Copy exisiting config
cd linux*
cp -v /boot/config-$(uname -r) .config

# Compile
make olddefconfig && make -j 2 && make modules_install && make install
# Remove older kernels (Only for demo! Not Production!)
rm -f /boot/*3.10*
# Update GRUB
grub2-mkconfig -o /boot/grub2/grub.cfg
grub2-set-default 0
echo "Grub update done."
# Reboot VM
shutdown -r now
