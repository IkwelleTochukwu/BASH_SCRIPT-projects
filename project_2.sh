#!/bin/bash
# Check the status (ping) of the server by shell script. Server ip should be sent as a command line arg. 
# If not sent give an error message. Send email of failure. 

# to define the target server
server=$1

# to set a number of ping requests
count=5    

if [ $# -eq 1 ]; then
    # to perform the ping request
    ping -c $count $server
    # to check the exit status to determine whether it is a success or failure 
    if [ $? -eq 0 ]; then
        echo "Server is reachable"
    else
        echo "Server is unreachable"
    fi
else
    echo "Usuage: $0 <server_IP_address>" | mail -s "Error in running $0 script" "your_email_address_@_email.com"
fi
