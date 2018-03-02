#!/bin/bash

##############
### CONFIG ###
##############

BASE_FOLDER=/home/$SUDO_USER/Downloads/
PT_TMP=PT_tar
TARGET_FOLDER="$BASE_FOLDER$PT_TMP"
PT_FOLDER=/opt/pt

# STRINGS
ERROR_STRING="Run 'sudo rm -rf ~/Downloads/PT_tar/' and run the script again"

# DEFINE FUNCTION
pushd () {
#    Strings for debugging
#    TEMP_FOLDER=$@
#    PUSHED_FOLDER=${TEMP_FOLDER#$HOME}
#    echo "cd from $DIRSTACK to $PUSHED_FOLDER"
    command pushd "$@" > /dev/null
}

popd () {
    command popd "$@" > /dev/null
}


if [ "$EUID" -ne 0 ]; then
  echo "Please run as root"
  exit
fi

if [ -d "$TARGET_FOLDER" ]; then
  echo $TARGET_FOLDER
  echo "Folder exists. $ERROR_STRING"
  exit
fi

#echo "Creating dir to unpack PT tar"
pushd "$BASE_FOLDER"
#cd $BASE_FOLDER

mkdir "$PT_TMP"
echo "Starting unpacking PT"
tar -xf $BASE_FOLDER/Packet\ Tracer\ 7.1.1\ for\ Linux\ 64\ bit.tar -C "$PT_TMP" 2> /dev/null
if [[ $? -ne 0 ]]
then
    echo "Something went wrong during untar pkg"
    echo "$ERROR_STRING"
    exit 1
else
    echo "Finish unpacking PT - Job complete without error"
fi

pushd "$PT_TMP"
#cd $PT_TMP
echo "Start running ~/Downloads/PT_tar/install"
./install
echo "Finish running ~/Downloads/PT_tar/install"


if [ -d "$PT_FOLDER" ]; then
  echo "PT copied in $PT_FOLDER"
  echo "Start removing: $PT_TMP"
  popd
  rm -rf $PT_TMP
  echo "Finish removing: $PT_TMP"
fi

# RETURN TO THE STARTER DIR
popd
rm -rf $TARGET_FOLDER


# PREREQUISITE
dpkg -s apt-file &>/dev/null
if [ $? -ne 0 ]; then
  sudo apt-get install apt-file
  sudo apt-file update
fi


PATH_PT=/opt/pt/bin

declare -a LIB_TO_INSTALL

MISSING_LIBS=`ldd "$PATH_PT/PacketTracer7" | grep -i "not found" | tr -s ' ' | cut -d'=' -f 1 |  sed -e 's/^[ \
t]*//'`

for i in $MISSING_LIBS
do
    #echo $i

    JDI=0
    LIB_I=`apt-file search $i | cut -d':' -f1 | uniq`

    for j in ${LIB_TO_INSTALL[@]}
    do
        if [[ $LIB_I == $j ]]
        then
            JDI=1
            continue
        fi
    done

    if [ $JDI -eq 0 ]
    then

        # REMOVED libqt5gui5-gles FOR CONFLICTS
        if [[ $LIB_I == *"gles"* ]]
        then
            LIB_I="libqt5gui5"
        fi

#        echo $LIB_I
        LIB_TO_INSTALL[${#LIB_TO_INSTALL[@]}]=$LIB_I
    fi

    # echo ${LIB_TO_INSTALL[@]}
done

echo ${LIB_TO_INSTALL[@]}
#echo ${#LIB_TO_INSTALL[@]}

apt-get install -y ${LIB_TO_INSTALL[@]}




sudo apt-get install -f

##### [CHECK IF INSTALLED] ####

dpkg -s libssl1.0.0 &>/dev/null
if [ $? -ne 0 ]; then
  # [UBUNTU]
  # https://packages.ubuntu.com/xenial/amd64/libssl1.0.0/download
  wget http://security.ubuntu.com/ubuntu/pool/main/o/openssl/libssl1.0.0_1.0.2g-1ubuntu4.10_amd64.deb
  sudo dpkg -i libssl1.0.0_1.0.2g-1ubuntu4.10_amd64.deb
  rm libssl1.0.0_1.0.2g-1ubuntu4.10_amd64.deb
  # DEBIAN - JESSIE
  # wget ftp.it.debian.org/debian/pool/main/o/openssl/libssl1.0.0_1.0.1t-1+deb8u7_amd64.deb
  # sudo dpkg -i libssl1.0.0_1.0.1t-1+deb8u7_amd64.deb
  # rm libssl1.0.0_1.0.1t-1+deb8u7_amd64.deb
fi

dpkg -s libicu52 &>/dev/null
if [ $? -ne 0 ]; then
  # [UBUNTU]
  wget de.archive.ubuntu.com/ubuntu/pool/main/i/icu/libicu52_52.1-3ubuntu0.7_amd64.deb
  sudo dpkg -i libicu52_52.1-3ubuntu0.7_amd64.deb
  rm libicu52_52.1-3ubuntu0.7_amd64.deb
  # [DEBIAN]
  #wget ftp.it.debian.org/debian/pool/main/i/icu/libicu52_52.1-8+deb8u6_amd64.deb
  # sudo dpkg -i libicu52_52.1-8+deb8u6_amd64.deb
  # rm libicu52_52.1-8+deb8u6_amd64.deb
fi
