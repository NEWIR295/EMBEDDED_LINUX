#!/bin/bash

#Author: Mohamed Newir
#Date: 06/02/2025
#Title: lab7.sh
#Description: shell scripts takes a file or directory as an input to check if its a file or directory
#             and if its a directory list its content 

# here we can use ~ here to refer to the home directory
var=$1

if [ -f $var ];
then
	echo "$var is an existing file"
elif [ -d $var ];
then
	echo "$var is an existing directory"
	for i in $(ls $var);do
		echo $i
	done
fi
