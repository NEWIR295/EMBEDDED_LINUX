#!/bin/bash

#Author: Mohamed Newir
#Date: 06/02/2025
#Title: lab3.sh
#Description: check the input value is even or odd , prime or not

number=$1 

#check is the number is even or odd
if [ $((number%2)) -eq 0 ];
then
    echo "The number is even"
else
    echo "The number is odd"
fi

#check is the number is prime or not
if [ $number -eq 2 ];
then
    echo "The number is prime"
else
    for ((i=2; i<=number/2; i++))
    do
        if [ $((number%i)) -eq 0 ];
        then
            echo "The number is not prime"
            exit
        fi
    done
    echo "The number is prime"
fi