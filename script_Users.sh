#!/bin/bash

#
# Scans for list of users on wifi network
#

#eval `ssh-agent -s` 


#if [ -z "$SSH_AUTH_SOCK" ] ; then
#  exec ssh-agent bash -c "ssh-add ; $0"
#  exit
#fi

# your raspberry pi login name
# default : pi

loginName='pi'
pathToFolder='/home/$loginName/scripts/'

# your private key name 
idName='id_rsa'

# Your ssh username and webserver address and port number
sshAddr='USERNAME@WEBSERVER'
portNumber='22'

# Path you want your folder and script to be in
pathToWebFolder='~/Insert/Path/To/Folder/Here'
pathToWebScript='~/Insert/Path/To/Script/Here/script.sh'

# Adding key pait
ssh-add /home/$loginName/.ssh/$id

# Scan using nmap. 
# -sP scans ports
# -oG output to file
# range of ip addresses and path

nmap -sP -oG  192.168.1.100-255 $pathToFolder/listOfIPAddress.txt
sleep 5

# Replace end of line with semicolon for easy parsing later
cat $pathToFolder/listOfIpAddress.txt | sed "s/$/;/" > $pathToFolder/list-parsed.txt;

# Send data using scp to webserver
scp -P $portNumber $pathtoFolder/list-parsed.txt $sshAddr:$pathToWebFolder

# Run script on webserver
ssh -p $portNumber $sshAddr $pathToWebScript

# Send RaspberryPi external IP address to webserver
curl "http://ipecho.net/plain" > $pathToFolder/externalIPAddress.txt
scp -P $portNumber $pathToFolder/externalIPAddress.txt $sshAddr:$pathToWebFolder

# Log last run date and time for debugging
echo `date` > $pathToFolder/date.log
scp -P $portNumber $pathToFolder/date.log $sshAddr:$pathToWebFolder

#kill $SSH_AGENT_PID

sleep 5

exit
