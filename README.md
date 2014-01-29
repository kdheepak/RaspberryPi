RaspberryPi
===========

Scripts run on my Raspberry Pi

Type the following

pi@raspberrypi:~$ env | grep SSH_AUTH_SOCK

SSH_AUTH_SOCK=/tmp/ssh-???????????/agent.XXXX

You need to add this to crontab.

Using terminal type 

crontab -e

Add the following lines to crontab.
The last two lines run the script every one minute.

SSH_AUTH_SOCK=/tmp/ssh-???????????/agent.XXXX

*/1 * * * * /home/pi/scripts/script_Temperature.sh
*/1 * * * * /home/pi/scripts/script_Users.sh
