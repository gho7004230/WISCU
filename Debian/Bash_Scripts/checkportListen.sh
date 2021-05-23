#!/bin/bash

# Path to write the logs to
logFile="/var/log/openPorts";

# If the log does not exist in t he current path, create a new log
if [[ ! -f $logFile ]];
    then netstat -l | grep LISTEN | grep -v unix > $logFile;
fi

# Read the md5
orgHash=$(md5sum -t $logFile | cut -f 1 -d " ");
echo "[+] The original hash is: $orgHash";

newHash=$(netstat -l | grep LISTEN | grep -v unix | md5sum -t | cut -f 1 -d " ");
echo "[+] The new hash is: $newHash";

if [[ $orgHash != $newHash ]];
    then
        echo "[-] There are changes in ports. this is the new port lists: "
        echo
        netstat -l | grep LISTEN | grep -v unix;
    else
        echo "[+] The port lists hasn't changed";
fi
