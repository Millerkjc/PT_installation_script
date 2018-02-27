#!/bin/bash

sudo apt-get install -f

##### [CHECK IF INSTALLED] ####

if [ $(dpkg -s libssl1.0.0 &>/dev/null) ]; then
  # [UBUNTU]
  # https://packages.ubuntu.com/xenial/amd64/libssl1.0.0/download
  wget http://security.ubuntu.com/ubuntu/pool/main/o/openssl/libssl1.0.0_1.0.2g-1ubuntu4.10_amd64.deb
  sudo dpkg -i libssl1.0.0_1.0.2g-1ubuntu4.10_amd64.deb
  # DEBIAN - JESSIE
  # wget ftp.it.debian.org/debian/pool/main/o/openssl/libssl1.0.0_1.0.1t-1+deb8u7_amd64.deb
  # sudo dpkg -i libssl1.0.0_1.0.1t-1+deb8u7_amd64.deb
fi

#### TO INSTALL ####

sudo apt-get install -y libqt5webkit5 libqt5multimedia5 libqt5printsupport5 libqt5svg5 \
                        libqt5widgets5 libqt5gui5 libqt5network5 libqt5xml5 libqt5script5 \
                        libqt5scripttools5 libqt5core5a


#### TO INSTALL ####

if [ $(dpkg -s libicu52 &>/dev/null) ]; then
  # [UBUNTU]
  wget de.archive.ubuntu.com/ubuntu/pool/main/i/icu/libicu52_52.1-3ubuntu0.7_amd64.deb
  sudo dpkg -i libicu52_52.1-3ubuntu0.7_amd64.deb

  # [DEBIAN]
  #wget ftp.it.debian.org/debian/pool/main/i/icu/libicu52_52.1-8+deb8u6_i386.deb
  # sudo dpkg -i libicu52_52.1-8+deb8u6_i386.deb
fi
