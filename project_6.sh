#!/bin/bash
# Write a shell script Lock all users whose names are in a file called users.txt 

file_name=$1   # assign the the file_name variable to the parameter

# to check if the parameter is used to run the script
if [ $# -eq 1 ]; then
    echo "Parsing file now..."
    if [ -e "$file_name" ]; then
        # Read usernames from the file into an array
        mapfile -t user_list < "$file_name"

        # to check if the users exists in the system and lock the users 
        for users in $user_list; do
            if id "$users" &>/dev/null; then
                echo "User $users exists!"
            else 
                echo "This user $users do not exist"
            fi

            sudo passwd -l "$users"
            echo "User $users is locked now"
        done
    else
        echo "Error: This file do not exists."
    fi
else
    echo  "Usauge: $0 <file>"
fi
 