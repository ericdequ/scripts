#!/bin/bash

# Update package lists and install prerequisites
sudo apt update
sudo apt install -y curl build-essential libssl-dev

# Install Python
sudo apt install -y python3 python3-pip
python3 --version
echo "Python installed successfully."

# Install Miniconda
wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh
bash Miniconda3-latest-Linux-x86_64.sh -b -p $HOME/miniconda
rm Miniconda3-latest-Linux-x86_64.sh
echo "export PATH=\"\$PATH:\$HOME/miniconda/bin\"" >> ~/.bashrc
source ~/.bashrc
conda --version
echo "Miniconda installed successfully."

# Install Golang
wget https://golang.org/dl/go1.17.6.linux-amd64.tar.gz
sudo tar -C /usr/local -xzf go1.17.6.linux-amd64.tar.gz
rm go1.17.6.linux-amd64.tar.gz
echo "export PATH=\$PATH:/usr/local/go/bin" >> ~/.bashrc
source ~/.bashrc
go version
echo "Golang installed successfully."

# Install Node.js, npm
curl -fsSL https://deb.nodesource.com/setup_lts.x | sudo -E bash -
sudo apt install -y nodejs
node --version
npm --version
echo "Node.js and npm installed successfully."

# Install pnpm
sudo npm install -g pnpm
pnpm --version
echo "pnpm installed successfully."

# Install yarn
curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo gpg --dearmor -o /usr/share/keyrings/yarn-archive-keyring.gpg
echo "deb [signed-by=/usr/share/keyrings/yarn-archive-keyring.gpg] https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list > /dev/null
sudo apt update
sudo apt install -y yarn
yarn --version
echo "yarn installed successfully."

# Install nvm
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | bash
source ~/.bashrc
nvm --version
echo "nvm installed successfully."

# Install Firebase CLI
sudo npm install -g firebase-tools
firebase --version
echo "Firebase CLI installed successfully."

# Install Vercel CLI
sudo npm install -g vercel
vercel --version
echo "Vercel CLI installed successfully."

# Install Git CLI
sudo apt install -y git
git --version
echo "Git CLI installed successfully."

# Reload shell to apply changes
source ~/.bashrc

echo "All requested software packages have been installed!"
