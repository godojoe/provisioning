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

echo 'install my packages...'
yum install -y kbd git vim-enhanced mc-4.8.7 nmap

echo 'configure mc...'
mkdir /home/vagrant/.config && mkdir /home/vagrant/.config/mc
cp /etc/mc/mc.keymap /home/vagrant/.config/mc
sed -i 's/.*CdParentSmart.*/CdParentSmart = backspace/g' /home/vagrant/.config/mc/mc.keymap

echo 'installing GNOME...'
yum groupinstall -y "X Window System" "Desktop" "General Purpose Desktop"
sed -i 's/id:3:initdefault/id:5:initdefault/g' /etc/inittab

echo mounting volumes
mount -t vboxsf -o uid=1000,gid=1000 vagrant /vagrant
