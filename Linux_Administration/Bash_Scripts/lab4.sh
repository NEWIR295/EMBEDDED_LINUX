#!/bin/bash

#Author: Mohamed Newir
#Date: 06/02/2025
#Title: lab4.sh
#Description: This script is used to display the content of an array 

#diplay input values
echo "diplay input values"
for var in "$@" ;do
    echo $var
done

#display the number of values
echo "display the number of values"
var="so Sad Bgd"
for i in $var;do
    echo $i
done    