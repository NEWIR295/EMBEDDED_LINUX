#!/bin/bash

#Author: Mohamed Newir
#Date: 06/02/2025
#Title: lab5.sh
#Description: shell script checks if a certain input file exists and if it does checks its permissions

#check if the file exists

if [ -f $1 ];
then
    echo "file $1 exists"
    #check the file permissions
    if [ -w $1 ];
    then
        echo "You have permission to edit $1"
    else
        echo "You do NOT have permission to edit $1"
    fi 
else
    echo "file $1 does not exist"
fi    