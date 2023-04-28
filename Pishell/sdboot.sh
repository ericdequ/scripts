#!/bin/bash

# Mount the boot partition of the SD card
sudo mount /dev/mmcblk0p1 /mnt

# Open the config.txt file and set the boot order to boot from the SD card first
sudo sed -i 's/^boot_order=.*/boot_order=0x1/' /mnt/config.txt

# Save and close the file
sudo umount /mnt
