#!/bin/bash

set -e

echo "Updating and upgrading packages..."
sudo apt update
sudo apt upgrade -y

echo "Installing necessary utilities..."
sudo apt install -y gparted

echo "Identifying the external hard drive partition with Raspberry Pi OS..."
EXTERNAL_PARTITION=$(lsblk -o NAME,TYPE,MOUNTPOINT | awk '$2=="part" && $3=="" {print $1}')

if [ -z "$EXTERNAL_PARTITION" ]; then
  echo "Error: Could not find an external partition with Raspberry Pi OS."
  exit 1
fi

echo "Getting the UUID of the partition..."
PARTUUID=$(sudo blkid | grep "$EXTERNAL_PARTITION" | awk -F' ' '{print $3}' | tr -d 'PARTUUID=' | tr -d '"')

if [ -z "$PARTUUID" ]; then
  echo "Error: Could not find the UUID of the partition."
  exit 1
fi

echo "Modifying the /boot/cmdline.txt file to boot from the external hard drive..."
sudo sed -i "s|root=[^ ]*|root=PARTUUID=$PARTUUID|" /boot/cmdline.txt

echo "Updating the /etc/fstab file..."
sudo sed -i "s|^\(/.*\)|#\1|" /etc/fstab
echo "PARTUUID=$PARTUUID / ext4 defaults,noatime 0 1" | sudo tee -a /etc/fstab

echo "Rebooting the Raspberry Pi..."
sudo reboot
