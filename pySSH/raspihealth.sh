#!/bin/bash


REMOTE_USER=$1
REMOTE_HOST=$2
REMOTE_PASSWORD=$3

IP_ADDRESS=$REMOTE_HOST

# Get the CPU temperature of the Raspberry Pi
CPU_TEMP=$(sshpass -p "$REMOTE_PASSWORD" ssh -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null "$REMOTE_USER"@"$IP_ADDRESS" "vcgencmd measure_temp" | awk -F'=' '{print $2}')

# Get the IP address of the Raspberry Pi
IP_ADDRESS=$(ping -c 1 raspberrypi | grep PING | awk '{print $3}' | tr -d '()')

# Get the CPU usage of the Raspberry Pi
CPU_USAGE=$(ssh pi@$IP_ADDRESS "top -bn1 | awk '/%Cpu/ {print \$2}'")

# Get the amount of free disk space on the Raspberry Pi
FREE_DISK_SPACE=$(ssh pi@$IP_ADDRESS "df -h / | tail -n 1" | awk '{print $4}')

# Get the amount of free RAM on the Raspberry Pi
FREE_RAM=$(ssh pi@$IP_ADDRESS "free -h" | awk '/Mem:/ {print $7}')

# Get the uptime of the Raspberry Pi
UPTIME=$(ssh pi@$IP_ADDRESS "uptime -p")

RUNNING_PROCESSES=$(ssh pi@$IP_ADDRESS "ps -A | wc -l")

# Get the number of open file descriptors on the Raspberry Pi
OPEN_FILE_DESCRIPTORS=$(ssh pi@$IP_ADDRESS "lsof | wc -l")

# Get the load average of the Raspberry Pi
LOAD_AVERAGE=$(ssh pi@$IP_ADDRESS "cat /proc/loadavg" | awk '{print $1}')


# Display the information
echo "IP address: $IP_ADDRESS"
echo "CPU temperature: $CPU_TEMP"
echo "CPU usage: $CPU_USAGE"
echo "Free disk space: $FREE_DISK_SPACE"
echo "Free RAM: $FREE_RAM"
echo "Uptime: $UPTIME"
echo "Number of running processes: $RUNNING_PROCESSES"
echo "Number of open file descriptors: $OPEN_FILE_DESCRIPTORS"
echo "Load average: $LOAD_AVERAGE"