#!/bin/bash

#Author: Mohamed Newir
#Date: 07/02/2025
#Title: lab12.sh
#Description: shell script that that displays number of files in the present working directory

file_count(){
    local count=0
    for file in $(ls);do 
        if [ -f $file ];then
            let count+=1
            echo "$file: $count"
        fi
    done
    return $count
}
file_count
number_of_files=$?
echo "Number of files in the present working directory is $number_of_files"