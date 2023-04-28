#!/bin/sh
# camera_setup.sh

# Update the package list
echo "Updating package list..."
sudo apt-get update

# Install required packages
echo "Installing required packages..."
sudo apt-get install -y libraspberrypi-bin

# Enable the camera module
echo "Enabling camera module..."
sudo raspi-config nonint do_camera 0

sudo pip3 install picamera

# Reboot the Raspberry Pi
echo "Camera module enabled. Please reboot your Raspberry Pi to apply changes:"
echo "sudo reboot"
