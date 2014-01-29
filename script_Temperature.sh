#!/bin/bash

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

# Save real time temperature. 
# Stored in realtimeTemperature.txt
/usr/local/bin/pcsensor > $pathToPiFolder/realtimeTemperature.txt
sleep 1

# Send data to webserver
scp -P $portNumber $pathToFolder/rtTemp.txt $sshAddr:$pathToWebFolder

# Run script on webserver
ssh -p $portNumber $sshAddr $pathToWebScript

# Save raspberry pi external ip address to the webserver
curl "http://ipecho.net/plain" > $pathToFolder/externalIPAddress.txt
scp -P $portNumber $pathToFolder/externalIPAddress.txt $sshAddr:$pathToWebFolder

# Save last run date and time for debugging
echo `date` > $pathToFolder/date.log
scp -P $portNumber $pathToFolder/date.log $sshAddr:$pathToWebFolder

#kill $SSH_AGENT_PID

sleep 5

exit
