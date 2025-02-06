#!/bin/bash

#Author: Mohamed Newir
#Date: 07/02/2025
#Title: lab11.sh
#Description:

sudo cat /etc/shadow
if [ $? -eq 0 ];then
    echo "Command succeeded"
    exit 0
else
    echo "Command failed"
    exit 1
fi