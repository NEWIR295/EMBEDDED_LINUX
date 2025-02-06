#!/bin/bash

#Author: Mohamed Newir
#Date: 07/02/2025
#Title: lab8.sh
#Description: shell scripts takes unlimited files or directories as an inputs to check if its a file or directory
#             and if its a directory list its content

# here we can use ~ here to refer to the home directory
count=0
for var in "$@"; do
    let count+=1
    echo "( $var ) is the $count file or directory to be Processed"
    if [ -f $var ]; then
        echo "$var is an existing file"
    elif [ -d $var ]; then
        echo "$var is an existing directory"
        for i in $(ls $var); do
            echo $i
        done
    fi
done
