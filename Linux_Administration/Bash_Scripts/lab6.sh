#!/bin/bash

#Author: Mohamed Newir
#Date: 06/02/2025
#Title: lab6.sh
#Description: shell scripts that asks the user for a file or directory to check if its a file or directory
#             and if its a directory list its content 

# here we can't use ~ to refer to the home directory
read -p "enter a file or directory to check its true nature: "  var

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
