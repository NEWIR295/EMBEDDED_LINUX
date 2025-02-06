#!/bin/bash

#Author: Mohamed Newir
#Date: 07/02/2025
#Title: ch1.sh
#Description: shell script that that displays number of files in the input directory

file_count(){
    local count=0
    for file in $(ls $1);do 
       # if [ -f $file ];then
            let count+=1
            echo "$file: $count"
        #fi
    done
    return $count
}
dir=$1
file_count $dir
number_of_files=$?
echo "Number of files in the $dir directory is $number_of_files"