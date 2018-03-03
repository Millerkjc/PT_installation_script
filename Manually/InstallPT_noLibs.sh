#!/bin/bash

##############
### CONFIG ###
##############
###################################################################

## PATHS
BASE_FOLDER=/home/$SUDO_USER/Downloads/
PT_TMP=PT_tar
TARGET_FOLDER="$BASE_FOLDER$PT_TMP"
PT_FOLDER=/opt/pt
PATH_PT=/opt/pt/bin

## STRINGS
ERROR_STRING="Run 'sudo rm -rf ~/Downloads/PT_tar/' and run the script again"

## FUNCTIONS
pushd () {
#    verbose string
#    Strings for debugging
#    TEMP_FOLDER=$@
#    PUSHED_FOLDER=${TEMP_FOLDER#$HOME}
#    echo "cd from $DIRSTACK to $PUSHED_FOLDER"
    command pushd "$@" > /dev/null
}

popd () {
    command popd "$@" > /dev/null
}

###################################################################


###############################
### FIRST STEP - INSTALL PT ###
###############################

## CHECK ROOT PRIVILEGE
if [ "$EUID" -ne 0 ]; then
  echo "Please run as root"
  exit
fi

## CHECK IF PT_TMP EXISTS
if [ -d "$TARGET_FOLDER" ]; then
  echo $TARGET_FOLDER
  echo "Folder exists. $ERROR_STRING"
  exit
fi


## START UNZIP PT

# verbose string
#echo "Creating dir to unpack PT tar"
pushd "$BASE_FOLDER"
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

# verbose string
echo "Start running ~/Downloads/PT_tar/install"
./install
echo "Finish running ~/Downloads/PT_tar/install"

## CLEAN DIR - RM PT_TMP
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
