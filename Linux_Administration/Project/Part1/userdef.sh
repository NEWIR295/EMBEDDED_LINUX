#!/bin/bash

#Author: Mohamed Newir
#Date: 28/02/2025
#File Name: userdef.sh
#Description:
#               This script is used to create a user with a specific password and group name
#               The script will also add the user to the group and update the user with a specific UID and GID
#               The script will also clean up the user and group created if the user wants to when passing the fourth argument as 1
#               The script will also check if the user is root before creating the user and group
#               The script will also check if the number of arguments passed to the script is valid
#               script will be as follows:
#                     ./userdef.sh <username> <password> <groupname> <clean>
#                     ./userdef.sh mohamed password123 group1 1 (to clean up the user and group created)
#                     ./userdef.sh mohamed password123 group1 0 (to create the user and group and update the user with a specific UID and GID)

arg="$#"   #Number of arguments passed to the script
clean="$4" #If the user wants to clean up the user and group created

#Function to clean up the user
clean_up_user() {
    echo "Cleaning up"
    sudo userdel -r $1
    echo "User $1 has been deleted"
}

#Function to clean up the group
# clean_up_group() {
#     echo "Cleaning up"
#     sudo groupdel $3
#     echo "Group $3 has been deleted"
# }

#main Program for creating the user and group and updating the user with a specific UID and GID

#Check if the number of arguments is valid
if [ "$arg" -eq 4 ]; then

    #Check if the user is root
    if [ "$EUID" -eq 0 ]; then #EUID of root is always Zero

        #Check if the user wants to clean up the user and group created
        if [ "$clean" -eq 1 ]; then
            clean_up_user $1
            sudo groupdel $3 # i really don't know why this is working here and not in the clean_up_group function ('__')
            echo "Group $3 has been deleted"
            # clean_up_group $3
            exit 0
        else
            #Create the user and group and update the user with a specific UID and GID
            echo "Creating user $1 with password $2 and the group name is $3"
            useradd -m -s /bin/bash $1 -N
            echo "$1:$2" | chpasswd
            id $1
            echo "User $1 has been created successfully"
            sudo groupadd -g 200 $3
            sudo usermod -aG $3 $1
            id $1
            echo "User $1 has been added to the group $3"
            sudo usermod -u 1600 -g $3 $1
            sudo usermod -aG sudo ahmed
            id $1
            echo "User $1 has been updated with UID 1600 and GID $3"
            exit 0
        fi

    else
        echo "Error: You must be root to run this script"
        exit 1
    fi

else
    echo "Error: Invalid number of arguments"
    exit 1
fi
