#!/bin/bash

TARGET_DIR=/home/ericd

# Update package lists, upgrade all packages, and install prerequisites
echo "Updating and upgrading all packages"
sudo apt-get update
sudo apt-get upgrade
sudo apt install -y curl build-essential libssl-dev
sudo apt-get install gcc g++ make 
     sudo apt-get update && sudo apt-get install yarn


# Update Python and related tools
echo "Updating Python and related tools"
sudo apt install -y python3 python3-pip
python3 --version

# Update Miniconda (ARM version for Raspberry Pi)
echo "Updating Miniconda"
conda update -n base -c defaults conda
conda update --all

# Update Golang for Raspberry Pi 4 (arm64 architecture)
echo "Updating Golang"
sudo rm -rf $TARGET_DIR/go
wget https://golang.org/dl/go1.20.3.linux-arm64.tar.gz
sudo tar -C $TARGET_DIR -xzf go1.20.3.linux-arm64.tar.gz
rm go1.20.3.linux-arm64.tar.gz
go version

# Update Node.js, npm, yarn, pnpm, and related tools
echo "Updating Node.js, npm, yarn, pnpm, and related tools"
curl -sL https://deb.nodesource.com/setup_lts.x | sudo -E bash -
sudo apt install -y nodejs
node --version
npm --version
sudo npm update -g
yarn --version
pnpm --version

# Update frontend frameworks: React, Next.js, and TypeScript
echo "Updating frontend frameworks"
sudo npm update -g create-react-app next typescript
create-react-app --version
next --version
tsc --version

# Update hosting tools: Firebase, Vercel, and Git
echo "Updating hosting tools"
sudo npm update -g firebase-tools vercel
firebase --version
vercel --version
git --

echo "All requested software packages have been updated! now running post update cleanup"
sudo clear

sudo apt autoremove
sudo apt-get clean
sudo apt-get update 
sudo apt-get upgrade -y
sudo apt-get dist-upgrade -y


echo "All requested software packages have been updated!"
echo "shutting off wait until green light has turned off and then unplug power"
echo "when you replug power the pi will be updated and ready to go"
echo ""
sleep 5


sudo poweroff

