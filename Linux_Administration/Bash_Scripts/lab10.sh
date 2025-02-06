#!/bin/bash

#Author: Mohamed Newir
#Date: 07/02/2025
#Title: lab10.sh
#Description: a shell script that takes an input and checks if it is a file or a directory

#we check the exit status with $? and if it is 0 then it is a file and if it is 1 then it is a directory 

if [ -f $1 ];
then
    echo "$1 is a file"
    exit 0
elif [ -d $1 ];
then
    echo "$1 is a directory"
    exit 1
else
    echo "$1 is not a file or a directory"
    exit 2
fi