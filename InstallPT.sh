#!/bin/bash

BASE_FOLDER=~/Downloads
PT_FOLDER=PT_tar
TARGET_FOLDER="$BASE_FOLDER/$PT_FOLDER"
ERROR_STRING="Run 'sudo rm -rf ~/Downloads/PT_tar/' and run the script again"

# FUNCTIONS
pushd(){
    TEMP_FOLDER=$@
    PUSHED_FOLDER=${TEMP_FOLDER#$HOME}
    echo "cd from $DIRSTACK to $DIRSTACK$PUSHED_FOLDER"
    command pushd "$@" > /dev/null
}


if [ "$EUID" -ne 0 ]; then
  echo "Please run as root"
  exit
fi

if [ -d "$TARGET_FOLDER" ]; then
  echo -n "Folder exists. $ERROR_STRING"
  exit
fi

echo "Creating dir to unpack PT tar"
pushd $BASE_FOLDER
mkdir $PT_FOLDER
echo "Starting unpacking PT"
tar -xf ~/Downloads/Packet\ Tracer\ 7.1.1\ for\ Linux\ 64\ bit.tar -C "$PT_FOLDER" 2> /dev/null
if [[ $? -ne 0 ]]
then
    echo "Something went wrong during untar pkg"
    echo "run 'sudo rm -rf ~/Downloads/PT_tar/' and run the script again"
    exit 1
else
    echo "Finish unpacking PT - Job complete without error"
fi

echo "Start running ~/Downloads/PT_tar/install"
./install
if [ $? -ne 0 ]; then
    echo "Problem during Cisco PT installation script"
fi
echo "Finish running ~/Downloads/PT_tar/install"


if [ -d "/opt/pt" ]; then
  echo TODO 
  exit
fi

# Should we create a symbolic link "packettracer" in /usr/local/bin for easy Cisco Packet Tracer startup? [Yn]
