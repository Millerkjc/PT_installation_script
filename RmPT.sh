sudo apt-get purge libqt5webkit5 libqt5multimedia5 libqt5printsupport5 libqt5svg5 libqt5widgets5 libqt5gui5 libqt5network5 libqt5xml5 libqt5script5 libqt5scripttools5 libqt5core5a

sudo dpkg --purge libicu52


rm -rf /opt/pt/
rm -f /usr/local/bin/packettracer
rm -rf /home/$SUDO_USER/Downloads/PT_tar/
