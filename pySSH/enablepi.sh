#!/bin/bash

remote_user=$1
remote_host=$2
remote_password=$3

send_command() {
  sshpass -p "$remote_password" ssh -o StrictHostKeyChecking=no -t "$remote_user@$remote_host" "$1"
}

enable_ssh() {
  echo "Enabling SSH..."
  send_command "sudo systemctl enable ssh; sudo systemctl start ssh"
  echo "SSH enabled."
}


setup_wifi_hotspot() {
  # Check if hostapd and dnsmasq are installed
  if ! dpkg -s hostapd &> /dev/null || ! dpkg -s dnsmasq &> /dev/null; then
    echo "Installing hostapd and dnsmasq..."
    send_command "sudo apt-get update; sudo apt-get install hostapd dnsmasq -y"
    echo "hostapd and dnsmasq installed."
  fi

  # Configure hostapd and dnsmasq
  send_command "sudo systemctl unmask hostapd; sudo systemctl enable hostapd; sudo systemctl start hostapd; sudo systemctl enable dnsmasq; sudo systemctl start dnsmasq"
  echo "Wi-Fi hotspot configured."
}


change_hostname() {
  echo "Enter the new hostname: "
  read new_hostname
  sudo hostnamectl set-hostname "$new_hostname"
  echo "Hostname changed to $new_hostname."
}

# Additional Raspberry Pi feature 1
install_retropie() {
  sudo apt-get update
  sudo apt-get install -y git lsb-release
  git clone --depth=1 https://github.com/RetroPie/RetroPie-Setup.git
  cd RetroPie-Setup
  sudo ./retropie_setup.sh
  cd ..
  rm -rf RetroPie-Setup
  echo "RetroPie installed. Enjoy your gaming!"
}

# Additional Raspberry Pi feature 2
setup_magic_mirror() {
  bash -c "$(curl -sL https://raw.githubusercontent.com/sdetweil/MagicMirror_scripts/master/raspberry.sh)"
  echo "MagicMirror installed. Configure it to display your desired information."
}

install_vnc_server() {
  echo "Installing VNC server..."
  sudo apt-get update
  sudo apt-get install realvnc-vnc-server realvnc-vnc-viewer -y
  echo "VNC server installed."
}

enable_i2c() {
  echo "Enabling I2C interface..."
  sudo raspi-config nonint do_i2c 0
  echo "I2C interface enabled."
}

enable_spi() {
  echo "Enabling SPI interface..."
  sudo raspi-config nonint do_spi 0
  echo "SPI interface enabled."
}

expand_filesystem() {
  echo "Expanding filesystem..."
  sudo raspi-config --expand-rootfs
  echo "Filesystem expanded."
}

update_raspi() {
  echo "Updating Raspberry Pi..."
  sudo apt-get update
  sudo apt-get dist-upgrade -y
  sudo rpi-update
  echo "Raspberry Pi updated."
}

install_docker() {
  echo "Installing Docker..."
  curl -fsSL https://get.docker.com | sh
  sudo usermod -aG docker pi
  echo "Docker installed."
}

raspi_features=("Enable SSH" "Set up Wi-Fi Hotspot" "Install VNC Server" "Enable I2C" "Enable SPI" "Expand Filesystem" "Update Raspberry Pi" "Install Docker" "Exit")

select_feature() {
  local features=("$@")
  local current_index=0
  local key

  while true; do
    tput clear
    for i in "${!features[@]}"; do
      if [[ $i -eq $current_index ]]; then
        tput setaf 7
        tput setab 4
      fi

      echo "${features[$i]}"
      tput sgr0
    done

    read -rsn3 key
    case $key in
      $'\x1B[A') ((current_index--)) ;;
      $'\x1B[B') ((current_index++)) ;;
      $'\x0A') break ;;
    esac

    ((current_index < 0)) && current_index=0
    ((current_index >= ${#features[@]})) && current_index=$((${#features[@]} - 1))
  done

  echo $current_index
}

main() {
  local actions=(enable_ssh setup_wifi_hotspot change_hostname install_retropie setup_magic_mirror install_vnc_server enable_i2c enable_spi expand_filesystem update_raspi install_docker)
  local selected_features=0

  while [[ $selected_features -lt 11 ]]; do
    local feature_index=$(select_feature "${raspi_features[@]}")
    [[ ${raspi_features[$feature_index]} == "Exit" ]] && break
    ${actions[$feature_index]}
    echo "${raspi_features[$feature_index]} applied."
    ((selected_features++))
  done

  echo "Configuration complete. Your Raspberry Pi 4 has been customized with the selected features."
}

main