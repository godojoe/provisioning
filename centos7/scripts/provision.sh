#!/bin/bash
# update puppetlabs pubkey
#yum update puppetlabs-release
#curl --remote-name --location https://yum.puppetlabs.com/RPM-GPG-KEY-puppet
#gpg --keyid-format 0xLONG --with-fingerprint ./RPM-GPG-KEY-puppet
#rpm --import RPM-GPG-KEY-puppet


#echo 'update os...'
yum update -y --exclude=kernel

echo 'set key layout...'
echo "loadkeys dk >> /dev/null 2>&1" > /etc/profile.d/keyboard.sh

echo 'install epel...'
yum install -y epel-release

echo 'install my packages...'
yum install -y kbd git vim-enhanced mc-4.8.7 nmap htop xrdp tigervnc-server

echo 'Enable Remote Desktop...'
systemctl start xrdp
systemctl enable xrdp

echo 'configure mc...'
mkdir /home/vagrant/.config && mkdir /home/vagrant/.config/mc
cp /etc/mc/mc.keymap /home/vagrant/.config/mc
sed -i 's/.*CdParentSmart.*/CdParentSmart = backspace/g' /home/vagrant/.config/mc/mc.keymap

echo 'installing GNOME...'
yum groupinstall -y "GNOME Desktop" "Graphical Administration Tools" "Server with GUI" --setopt=group_package_types=mandatory,default,optional
systemctl set-default graphical.target

echo mounting volumes
mount -t vboxsf -o uid=1000,gid=1000 vagrant /vagrant
