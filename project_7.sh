#!/bin/bash
# Write a shell script recycle log files in /var directory 
# remove oldest lines. 
# Put this in a crontab. 
# make sure that you have atleast 1000 lines in the file. 

# The directory path
directory_path="/var/log"

# To check if the directory exits
if [ -d "$directory_path" ]; then

    # To enter the /var/log directory 
    cd "$directory_path" || exit

    # List contents of the directory
    List_of_files=$(sudo find . -type f) 2> /dev/null  # using find command to recursively find files in the directory and sub-dirs

    # Iterate over the list of files and check if they are a file
    for log_file in $List_of_files; do
        if [ -f "$log_file" ]; then

            # use wc command to count the number lines in the file
            number_of_lines_to_keep=1000
            line_count=$( sudo wc -l < "$log_file" )
            # check if the file have at least 1000 lines
            if [ "$line_count" -ge "$number_of_lines_to_keep" ]; then
                # calculate number of lines to remove
                lines_to_remove=$((line_count - number_of_lines_to_keep))
                # Use tail to get the lines to keep, and sed to remove the remaining lines
                sudo tail -n "$number_of_lines_to_keep" "$log_file" > "$log_file.modified"
                sudo sed -i "1,${lines_to_remove}d" "$log_file.modified"
                sudo mv "$log_file.modified" "$log_file"
            fi
        fi
    done
else
    echo "The /var/log directory do not exists"
fi




