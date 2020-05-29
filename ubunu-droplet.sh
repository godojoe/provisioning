sudo apt-get update && sudo apt-get dist-upgrade -y
sudo apt-get install --no-install-recommends ubuntu-mate-core ubuntu-mate-desktop -y
sudo apt-get install mate-core mate-desktop-environment mate-notification-daemon xrdp -y
adduser remote
usermod -aG admin remote
usermod -aG sudo remote
su - remote
echo mate-session> ~/.xsession
sudo cp /home/remote/.xsession /etc/skel
sudo service xrdp restart