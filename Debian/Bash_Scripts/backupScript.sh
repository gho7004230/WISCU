#!/bin/bash
# The path of the folder to back up
backup_files="/home/"

# Backup Destination Path
dest="/tmp"

# Create a variable for the start/end time
now=$(date +"%H:%M:%S")

# Create the archive filename
currentDate=$(date +"%y-%m-%d")
hostname=$(hostname -s)
archive_file="$hostname-$currentDate.tgz"

# Let the user know that the process is starting
echo "Backing up $backup_files to $dest/$archive_file"
echo "Process is starting."

# Print the Start Time
echo Script start time: "$now"

# Back up  the files using the tar command
tar czfP $dest/$archive_file $backup_files

# Print the end status message
echo "Backup Finished!"
echo Script end time: "$now"
