#!/bin/bash
# Write a shell script Lock all users between UID 500 and 530 

# User ID range
MIN_UID=500
MAX_UID=530

# Get list of users and print out
USERS=$(awk -F':' -v min=$MIN_UID -v max=$MAX_UID '$3 >= min && $3 <= max {print $1}' /etc/passwd)

# Check if users are within the UID range of 500 to 530
if [ -n "$USER" ]; then
    echo "Users with UID between 530 and 500:"
    echo "$USERS"
else
    echo "There are no users within the UID range of 530 to 500"
fi

