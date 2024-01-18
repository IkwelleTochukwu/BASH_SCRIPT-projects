#!/bin/bash
# Write a shell script for generating File system space utilization report. 
# Indent the content of report nicely. 
# The report should be sent every morning at 8:00 AM

# directory to store the reports
disk_report_dir="$HOME/disk_report"

# check if directory exists, and creates one, if it doesn't
mkdir -p $disk_report_dir

# file system space utilization report, using the 'df' command
df -h > "$disk_report_dir/df_report.txt"

echo "File system utilization report is generated and stored in $disk_report_dir"