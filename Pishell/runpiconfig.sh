#!/bin/bash

# Update this with the appropriate values for your scenario
REMOTE_USER="ericd"
REMOTE_HOST="192.168.0.144"
REMOTE_PASSWORD="pass"

# Install 'expect' and 'sshpass' if not installed
apt-get update
apt-get install -y expect sshpass

# Copy the scripts to the remote computer
expect -c "
set timeout 10
spawn scp autosetup.sh ${REMOTE_USER}@${REMOTE_HOST}:/home/${REMOTE_USER}/
expect \"*password:\"
send \"${REMOTE_PASSWORD}\r\"
expect eof
"

expect -c "
set timeout 10
spawn scp newmenupi.sh ${REMOTE_USER}@${REMOTE_HOST}:/home/${REMOTE_USER}/
expect \"*password:\"
send \"${REMOTE_PASSWORD}\r\"
expect eof
"

# Install dos2unix and run the scripts on the remote computer
sshpass -p ${REMOTE_PASSWORD} ssh ${REMOTE_USER}@${REMOTE_HOST} "
  cd /home/${REMOTE_USER} &&
  sudo apt-get update && sudo apt-get install -y dos2unix &&
  dos2unix autosetup.sh &&
  dos2unix newmenupi.sh &&
  chmod +x autosetup.sh &&
  chmod +x newmenupi.sh &&
  ./autosetup.sh
"
