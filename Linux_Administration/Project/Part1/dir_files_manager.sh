#!/bin/bash

#Author: Mohamed Newir
#Date: 28/02/2025
#File Name: dir_files_manager.sh
#Description:
#               This script is used to create a directory and files and compress them to a tar file
#               The script will also check if the directory exists and delete it
#               The script will also check if the tar file exists and delete it
#               The script will also check if the user exists and copy the tar file to the user home directory and extract it
#               script will be as follows:
#                     ./dir_files_manager.sh <new_user>

#global variables
new_user="$1"
new_user_home="/home/$new_user"
dir="./dir_files_manager"

#Check if the directory exists and delete it 
if [ -d "$dir" ]; then
    sudo rm -r "$dir"
    echo "Directory $dir has been deleted"
fi

#Check if the tar file exists and delete it
if [ -f "$dir.tar.gz" ]; then
    sudo rm "$dir.tar.gz"
    echo "File $dir.tar.gz has been deleted"
fi

#Create the directory and the files 
mkdir "$dir" && cd "$dir" && touch main.c main.h hello.c hello.h
echo "Directory $dir has been created"
echo "Files main.c main.h hello.c hello.h have been created"

for file in $(ls .);do 
    echo "this file is named $file" >> $file
done

cd ..
tar -cvzf "$dir".tar.gz "$dir"
echo "Directory $dir has been compressed to $dir.tar.gz"

if [ ! -d "$new_user_home" ];then
    echo "User $new_user does not exist"
    exit 1
else

    # sudo bash -c : run multiple commands as root in the same shell without leaving the current shell  
    sudo bash -c "
    cp '$dir.tar.gz' '$new_user_home' &&
    cd '$new_user_home' &&
    tar -xvzf '$dir.tar.gz'
    "
    echo "$dir.tar.gz has been extracted"
fi


