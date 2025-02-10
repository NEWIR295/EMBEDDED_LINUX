#!/bin/bash

#Author: Mohamed Newir
#Date: 07/02/2025
#Title: ch3.sh
#Description:

fileToRename="$1"
date=$(date +"%Y-%m-%d")
dir="."

if [ ! -f $fileToRename ] && [ ! -d $fileToRename ]; then
    echo "file or directory does not exist"
    exit 1
fi

read -p "enter a file or directory to change it name: " name

if [ -z "$name" ]; then
    name="$date"
fi

if [ -n "$name" ] && [ -f $name ] || [ -d $name ]; then
    echo "file or directory $name already exists"
    exit 1
fi

fileName=$(basename "$fileToRename")
newName="${name}-${fileName}"
mv "$fileToRename" "$newName"

echo "renamed ${fileName} to ${newName}"
