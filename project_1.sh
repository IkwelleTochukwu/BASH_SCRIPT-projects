#!/bin/bash
# Write a shell script for downloading a file from ftp server. 
# schedule it to run at a specific time. 
# send success or failure email. 
# Use command line arguments for sending ip of the ftp server and loginID & password 

# check if all the required arguments are provided
if [ $# -eq 3 ]; then
    echo "Usuage: $0 <FTP_SERVER_IP> <FTP_USER_ID> <PASSWORD>"
fi

FTP_SERVER_IP=$1
FTP_USER_ID=$2
PASSWORD=$3
FILE_DOWNLOAD=" "  # input file to download from ftp server
LOCAL_FILE_PATH=" "  # input local file path

# Function to send email on success or failure
send_email() {
    local SUBJECT=$1
    local BODY=$2

    echo "$BODY" | mail -s "$SUBJECT" your@email.com    # input your email address
}

# Function to download file from FTP server
download_file() {
    ftp -n $FTP_SERVER_IP <<END_SCRIPT
    quote USER $FTP_USER_ID
    quote PASS $PASSWORD
    binary
    get $FILE_DOWNLOAD $LOCAL_FILE_PATH/$FILE_DOWNLOAD
    quit
END_SCRIPT

    # Check if the download was successful
    if [ $? -eq 0 ]; then
        send_email "FTP Download Successful" "File $FILE_DOWNLOAD downloaded successfully."
    else
        send_email "FTP Download Failed" "Failed to download file $FILE_DOWNLOAD from FTP server."
    fi
}

# Schedule the script to run at a specific time using cron
# For example, to run the script every day at 3:00 AM, add the following line to your crontab:
# 0 3 * * * /path/to/your/script.sh <FTP_SERVER_IP> <LOGIN_ID> <PASSWORD>

# Uncomment the line below if you want to execute the download immediately (for testing purposes)
# download_file
