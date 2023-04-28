#!/bin/bash

TARGET_DIR=/home/ericd

# Update package lists and install prerequisites
sudo apt-get update
sudo apt-get upgrade
sudo apt install -y curl build-essential libssl-dev

echo "installing backend tools such as python pip conda and golang"

# Install Python
echo "installing python"
sudo apt install -y python3 python3-pip
python3 --version
echo "Python installed successfully."

# Install Miniconda (ARM version for Raspberry Pi)
echo "installing conda"
wget https://github.com/conda-forge/miniforge/releases/latest/download/Miniforge3-Linux-aarch64.sh
bash Miniforge3-Linux-aarch64.sh -b -p $TARGET_DIR/miniconda
rm Miniforge3-Linux-aarch64.sh
echo "export PATH=\"\$PATH:$TARGET_DIR/miniconda/bin\"" >> ~/.bashrc
source ~/.bashrc
conda --version
echo "Miniconda installed successfully."


# Install Golang for Raspberry Pi 4 (arm64 architecture)
echo "installing go"
wget https://golang.org/dl/go1.20.3.linux-arm64.tar.gz
sudo tar -C $TARGET_DIR -xzf go1.20.3.linux-arm64.tar.gz
rm go1.20.3.linux-arm64.tar.gz
echo "export PATH=\$PATH:$TARGET_DIR/go/bin" >> ~/.bashrc
echo "export GOPATH=$TARGET_DIR/go" >> ~/.bashrc
echo "export PATH=\$PATH:\$GOPATH/bin" >> ~/.bashrc
source ~/.bashrc
go version
echo "Golang installed successfully."


echo "install front end tools node npm yarn pnpm" 
# Install Node.js, npm
echo "installing nodejs and npm"
curl -sL https://deb.nodesource.com/setup_lts.x | sudo -E bash -
sudo apt install -y nodejs
node --version
npm --version
echo "Node.js and npm installed successfully."

# Install pnpm
echo "installing pnpm"
sudo npm install -g pnpm
pnpm --version
echo "pnpm installed successfully."


# Install yarn
echo "installing yarn"
curl -sL https://dl.yarnpkg.com/debian/pubkey.gpg | sudo gpg --dearmor -o /usr/share/keyrings/yarn-archive-keyring.gpg
echo "deb [signed-by=/usr/share/keyrings/yarn-archive-keyring.gpg] https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list > /dev/null
sudo apt update
sudo apt install -y yarn
yarn --version
echo "yarn installed successfully."


echo "installing frontend frameworks react nextjs typescript"
# Install React globally
echo "installing react"
sudo npm install -g create-react-app
create-react-app --version
echo "React installed successfully."

# Install Next.js globally
echo "installing next"
sudo npm install -g next
next --version
echo "Next.js installed successfully."

# Install TypeScript globally
echo "installing Typescript"
sudo npm install -g typescript
tsc --version
echo "TypeScript installed successfully."

# Update TypeScript types
echo "installing types"
sudo npm install -g @types/node
@types/react
echo "TypeScript types updated successfully."

# Install nvm
echo "installing nvm"
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | bash
source ~/.bashrc
nvm --version
echo "nvm installed successfully."



echo "installing hosting tools firebase vercel git"

# Install Firebase CLI
echo "installing firebase"
sudo npm install -g firebase-tools
firebase --version
echo "Firebase CLI installed successfully."

# Install Vercel CLI
echo "installing vercel"
sudo npm install -g vercel
vercel --version
echo "Vercel CLI installed successfully."

# Install Git CLI
echo "installing git"
sudo apt install -y git
git --version
echo "Git CLI installed successfully."

# echo "enabling raspi features"
Enable Camera module
echo "enabling camera module ..."
sudo raspi-config nonint do_camera 0
echo "Camera module enabled."


# Enable SSH
echo "enabling ssh ..."
sudo systemctl enable ssh
sudo systemctl start ssh
echo "SSH enabled."


#Install RealVNC Server and enable remote access
echo "enabling vnc ..."
sudo apt install -y realvnc-vnc-server
sudo raspi-config nonint do_vnc 0
echo "VNC Server installed and remote access enabled."

#Reload shell to apply changes
source ~/.bashrc

echo "All requested software packages have been installed and configurations applied! rebooting now ..."
sudo reboot

# Commands to run after reboot
echo "Waiting for reboot to complete..."
sleep 120 # Wait for 60 seconds after reboot
echo "Reboot complete. Running post-reboot commands..."

# Add your post-reboot commands here
# For example:
#!/bin/bash

echo "Running post-reboot commands..."
echo "ensuring latest versions of all packages are installed"

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

