#!/bin/bash
# Write a shell that will check the status (Ping) of entire network. 
# send the list of down servers as a email attachment to respective authority 
# The list of server is kept in a file named /opt/server_list.txt 

for i in {3..225}; do ping -c 1 -W 1 192.168.1.$i  # to iterate through a network of servers with IP address from 192.168.1.3 to 192.168.1.225
    if [ $? -ne 0 ]; then
        echo $i >> "/opt/server_list.txt"  # to input the server list into the /opt/server_list.txt file

        # email information
        Recipient="your_email@email.com"  # input a valid email address
        Subject="Down_server list"
        Body="Find an attachment of the list of down servers in the /opt/server_list.txt file"

        # send email attachment
        mail -s "$Subject" -a "/opt/server.txt" "$Recipient" <<< "$Body"
        echo "Email sent with attachment"
    fi
done

