#!/bin/bash

BASE_FOLDER=~/Downloads
PT_FOLDER=PT_tar
TARGET_FOLDER="$BASE_FOLDER/$PT_FOLDER"

if [ "$EUID" -ne 0 ]; then
  echo "Please run as root"
  exit
fi

if [ -d "$TARGET_FOLDER" ]; then
  echo "Folder exists. Run 'sudo rm -rf ~/Downloads/PT_tar/' and run the script again"
  exit
fi

echo "Creating dir to unpack PT tar"
mkdir "$TARGET_FOLDER"
echo "Starting unpacking PT"
tar -xf ~/Downloads/Packet\ Tracer\ 7.1.1\ for\ Linux\ 64\ bit.tar -C "$TARGET_FOLDER" 2> /dev/null
if [[ $? -ne 0 ]]
then
    echo "Something went wrong during untar pkg"
    echo "run 'sudo rm -rf ~/Downloads/PT_tar/' and run the script again"
    exit 1
else
    echo "Finish unpacking PT - Job complete without error"
fi

echo "Start running ~/Downloads/PT_tar/install"
$TARGET_FOLDER/install
echo $?
echo "Finish running ~/Downloads/PT_tar/install"



