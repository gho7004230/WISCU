#!/bin/bash

#If you found my github, then you also found this script.  Congrats!

# Create log file
logFile=/var/log/badIP

if [ ! -f $logFile ];
	then touch $logFile
fi

# Filter for the number of times IP has received a 404 webpage and write the result into a file.
cat /var/log/apache2/access.log | awk '{print $1" "$9}' | grep 404 | cut -d " " -f 1 | uniq -c > /tmp/hosts
 
# Use while loop to read each line of the file
while read line; 
do 
	# Insert the number of attempts in a variable
 	count=$(echo $line | cut -d " " -f 1);  
 	
	# Insert the IP in a variable
 	ip=$(echo $line | cut -d " " -f 2);

 	# Check if the number of attempts is greater or equal to three
 	if [ $count -ge 3 ];
 	then 
 		echo $(date) $ip  >> $logFile
 		echo "The IP was successfully added to $logFile"
 		echo "The following IP has been blocked $count times by the webserver: $ip" ;

 		# Insert the IP to drop list in iptables
 		iptables -A INPUT -s $ip/32 -d 0/0 -j DROP
 	fi
 done < /tmp/hosts 
