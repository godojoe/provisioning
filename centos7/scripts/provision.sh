#!/bin/bash
# update puppetlabs pubkey
#yum update puppetlabs-release
#curl --remote-name --location https://yum.puppetlabs.com/RPM-GPG-KEY-puppet
#gpg --keyid-format 0xLONG --with-fingerprint ./RPM-GPG-KEY-puppet
#rpm --import RPM-GPG-KEY-puppet


#echo 'update os...'
yum update -y

echo 'install epel...'
yum install -y epel-release

echo 'installing GNOME...'
yum groupinstall -y "GNOME Desktop" "Graphical Administration Tools" "Server with GUI" --setopt=group_package_types=mandatory,default,optional
yum remove -y gnome-initial-setup
systemctl isolate graphical.target
systemctl set-default graphical.target 
systemctl start graphical.target 

echo 'install my packages...'
yum install -y git vim-enhanced mc-4.8.7 nmap htop xrdp tigervnc-server

echo 'Enable Remote Desktop...'
systemctl start xrdp
systemctl enable xrdp

echo 'configure mc...'
mkdir /home/vagrant/.config && mkdir /home/vagrant/.config/mc
cp /etc/mc/mc.keymap /home/vagrant/.config/mc
sed -i 's/.*CdParentSmart.*/CdParentSmart = backspace/g' /home/vagrant/.config/mc/mc.keymap

echo 'set key layout...'
sed -i 's/^KEYMAP="us"$/KEYMAP="dk"/' /etc/vconsole.conf