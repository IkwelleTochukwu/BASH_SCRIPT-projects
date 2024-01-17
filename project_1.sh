#!/bin/bash
# Write a shell script for downloading a file from ftp server. 
# schedule it to run at a specific time. 
# send success or failure email. 
# Use command line arguments for sending ip of the ftp server and loginID & password 

SUBJECT_OF_EMAIL="Notice for mailing"
RECIPIENT_OF_EMAIL="xyz@email.com"  # input your email


# pass command line arguments
while getopts ":s:u:p" opt; do
    case $opt in
        s)
            FTP_SERVER="$OPTARG"
            ;;
        u)
            FTP_USER="$OPTARG"
            ;;
        p)
            FTP_PASSWORD="$OPTARG"
            ;;
        \?)
            echo "Invalid option: -$OPTARG" >&2
            exit 1
            ;;
        :)
            echo "Option -$OPTARG requires an argument." >&2
            exit 1
            ;;
    esac
done

# File details
REMOTE_FILE=
LOCAL_FILE=

# download the file using the wget command
wget --ftp-user="$FTP_USER" --ftp-password="$FTP_PASSWORD" "ftp://$FTP_SERVER$REMOTE_FILE" -O "$LOCAL_FILE"

# To check if it was succesful and send message accordingly
if [ $? -eq 0 ]; then
    echo "File is downloaded successfully"
    # send success email
    echo "sending mail ...." | mail -s "$SUBJECT_OF_EMAIL" "$RECIPIENT"
else
    echo "Error! unable to download file"
    # send failure email
    echo "sending mail ...." | mail -s "$SUBJECT_OF_EMAIL" "$RECIPIENT"
fi
