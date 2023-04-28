#!/bin/bash

TARGET_DIR=/home/ericd

install_prerequisites() {
  sudo apt-get update
  sudo apt-get upgrade
  sudo apt install -y curl build-essential libssl-dev
}

install_python() {
  echo "installing python"
  sudo apt install -y python3 python3-pip
  python3 --version
  echo "Python installed successfully."
}

install_conda() {
  echo "installing conda"
  wget https://github.com/conda-forge/miniforge/releases/latest/download/Miniforge3-Linux-aarch64.sh
  bash Miniforge3-Linux-aarch64.sh -b -p $TARGET_DIR/miniconda
  rm Miniforge3-Linux-aarch64.sh
  echo "export PATH=\"\$PATH:$TARGET_DIR/miniconda/bin\"" >> ~/.bashrc
  source ~/.bashrc
  conda --version
  echo "Miniconda installed successfully."
}

install_go() {
  read -p "Enter the Go version you want to install (e.g., 1.20.3): " version
  version=${version:-1.20.3}
  echo "Installing Go version $version"
  wget https://golang.org/dl/go$version.linux-arm64.tar.gz
  sudo tar -C $TARGET_DIR -xzf go$version.linux-arm64.tar.gz
  rm go$version.linux-arm64.tar.gz
  echo "export PATH=\$PATH:$TARGET_DIR/go/bin" >> ~/.bashrc
  echo "export GOPATH=$TARGET_DIR/go" >> ~/.bashrc
  echo "export PATH=\$PATH:\$GOPATH/bin" >> ~/.bashrc
  source ~/.bashrc
  go version
  echo "Golang installed successfully."
}


install_node_npm() {
  echo "installing nodejs and npm"
  curl -sL https://deb.nodesource.com/setup_lts.x | sudo -E bash -
  sudo apt install -y nodejs
  node --version
  npm --version
  echo "Node.js and npm installed successfully."
}

install_pnpm() {
  echo "installing pnpm"
  sudo npm install -g pnpm
  pnpm --version
  echo "pnpm installed successfully."
}



install_yarn() {
  echo "installing yarn"
  curl -sL https://dl.yarnpkg.com/debian/pubkey.gpg | sudo gpg --dearmor -o /usr/share/keyrings/yarn-archive-keyring.gpg
  echo "deb [signed-by=/usr/share/keyrings/yarn-archive-keyring.gpg] https://dl.yarnpkg.com/debian stable main" | sudo tee /etc/apt/sources.list.d/yarn.list
  sudo apt update && sudo apt install yarn
  yarn --version
  echo "Yarn installed successfully."
}

install_git() {
  echo "installing git"
  sudo apt install -y git
  git --version
  echo "Git installed successfully."
}

install_docker() {
  echo "installing docker"
  curl -fsSL https://get.docker.com -o get-docker.sh
  sudo sh get-docker.sh
  rm get-docker.sh
  sudo usermod -aG docker $USER
  echo "Docker installed successfully."
}

install_postgresql() {
  echo "installing postgresql"
  sudo apt install -y postgresql postgresql-contrib
  sudo systemctl enable postgresql
  sudo systemctl start postgresql
  echo "PostgreSQL installed successfully."
}

install_redis() {
  echo "installing redis"
  sudo apt install -y redis-server
  sudo systemctl enable redis-server
  sudo systemctl start redis-server
  echo "Redis installed successfully."
}

install_nginx() {
  echo "installing nginx"
  sudo apt install -y nginx
  sudo systemctl enable nginx
  sudo systemctl start nginx
  echo "Nginx installed successfully."
}

install_vscode() {
  echo "installing Visual Studio Code"
  curl -fsSL https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg
  sudo install -o root -g root -m 644 packages.microsoft.gpg /etc/apt/trusted.gpg.d/
  echo "deb [arch=amd64,arm64,armhf signed-by=/etc/apt/trusted.gpg.d/packages.microsoft.gpg] https://packages.microsoft.com/repos/code stable main" | sudo tee /etc/apt/sources.list.d/vscode.list
  sudo apt update
  sudo apt install -y code
  rm packages.microsoft.gpg
  echo "Visual Studio Code installed successfully."
}

install_jdk() {
  echo "installing JDK"
  sudo apt install -y default-jdk
  java -version
  echo "JDK installed successfully."
}

install_maven() {
  echo "installing Maven"
  sudo apt install -y maven
  mvn -version
  echo "Maven installed successfully."
}

install_gradle() {
  echo "installing Gradle"
  sudo apt install -y gradle
  gradle -version
  echo "Gradle installed successfully."
}

install_ruby() {
  echo "installing Ruby"
  sudo apt install -y ruby-full
  ruby -v
  echo "Ruby installed successfully."
}

install_rails() {
  echo "installing Rails"
  sudo gem install rails
  rails -v
  echo "Rails installed successfully."
}

install_elasticsearch() {
  echo "installing Elasticsearch"
  curl -fsSL https://artifacts.elastic.co/GPG-KEY-elasticsearch | sudo gpg --dearmor -o /usr/share/keyrings/elasticsearch-archive-keyring.gpg
  echo "deb [arch=amd64 signed-by=/usr/share/keyrings/elasticsearch-archive-keyring.gpg] https://artifacts.elastic.co/packages/7.x/apt stable main" | sudo tee /etc/apt/sources.list.d/elastic-7.x.list
  sudo apt update
  sudo apt install -y elasticsearch
  sudo systemctl enable elasticsearch.service
  sudo systemctl start elasticsearch.service
  echo "Elasticsearch installed successfully."
}

install_firebase() {
  echo "installing Firebase CLI"
  sudo npm install -g firebase-tools
  firebase --version
  echo "Firebase CLI installed successfully."
}

install_vercel() {
  echo "installing Vercel CLI"
  sudo npm install -g vercel
  vercel --version
  echo "Vercel CLI installed successfully."
}

install_r_rstudio() {
  echo "installing R and RStudio"
  sudo apt install -y r-base
  R --version
  sudo apt install -y gdebi-core
  wget https://download1.rstudio.org/desktop/bionic/amd64/rstudio-2023.04.1-amd64.deb
  sudo gdebi -n rstudio-2023.04.1-amd64.deb
  rm rstudio-2023.04.1-amd64.deb
  echo "R and RStudio installed successfully."
}

install_mysql() {
  echo "installing MySQL"
  sudo apt install -y mysql-server
  sudo systemctl enable mysql
  sudo systemctl start mysql
  echo "MySQL installed successfully."
}

install_mongodb() {
  echo "installing MongoDB"
  wget -qO - https://www.mongodb.org/static/pgp/server-5.0.asc | sudo apt-key add -
  echo "deb [ arch=amd64,arm64 ] https://repo.mongodb.org/apt/ubuntu $(lsb_release -cs)/mongodb-org/5.0 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-5.0.list
  sudo apt update
  sudo apt install -y mongodb-org
  sudo systemctl enable mongod
  sudo systemctl start mongod
  echo "MongoDB installed successfully."
}

install_apache() {
  echo "installing Apache"
  sudo apt install -y apache2
  sudo systemctl enable apache2
  sudo systemctl start apache2
  echo "Apache installed successfully."
}

install_php() {
  echo "installing PHP"
  sudo apt install -y php libapache2-mod-php php-mysql
  php --version
  echo "PHP installed successfully."
}

install_dotnet_sdk() {
  echo "installing .NET SDK"
  wget https://packages.microsoft.com/config/ubuntu/20.04/packages-microsoft-prod.deb -O packages-microsoft-prod.deb
  sudo dpkg -i packages-microsoft-prod.deb
  rm packages-microsoft-prod.deb
  sudo apt update
  sudo apt install -y dotnet-sdk-6.0
  dotnet --version
  echo ".NET SDK installed successfully."
}

install_rust() {
  echo "installing Rust"
  curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
  source $HOME/.cargo/env
  rustc --version
  echo "Rust installed successfully."
}

install_chrome() {
  echo "installing Google Chrome"
  wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
  sudo dpkg -i google-chrome-stable_current_amd64.deb
  sudo apt --fix-broken install
  rm google-chrome-stable_current_amd64.deb
  echo "Google Chrome installed successfully."
}

install_chromedriver() {
  echo "installing ChromeDriver"
  CHROME_VERSION=$(google-chrome --version | awk '{print $3}' | awk -F. '{print $1}')
  DRIVER_VERSION=$(curl -s "https://chromedriver.storage.googleapis.com/LATEST_RELEASE_$CHROME_VERSION")
  wget "https://chromedriver.storage.googleapis.com/$DRIVER_VERSION/chromedriver_linux64.zip"
  unzip chromedriver_linux64.zip
  sudo mv chromedriver /usr/local/bin/
  rm chromedriver_linux64.zip
  echo "ChromeDriver installed successfully."
}

install_spotify() {
  echo "installing Spotify"
  curl -sS https://download.spotify.com/debian/pubkey_5E3C45D7B312C643.gpg | sudo gpg --dearmor -o /usr/share/keyrings/spotify-archive-keyring.gpg
  echo "deb [signed-by=/usr/share/keyrings/spotify-archive-keyring.gpg] http://repository.spotify.com stable non-free" | sudo tee /etc/apt/sources.list.d/spotify.list
  sudo apt update
  sudo apt install -y spotify-client
  echo "Spotify installed successfully."
}

install_discord() {
  echo "installing Discord"
  wget -O ~/discord.deb "https://discordapp.com/api/download?platform=linux&format=deb"
  sudo dpkg -i ~/discord.deb
  sudo apt-get install -f -y
  rm ~/discord.deb
  echo "Discord installed successfully."
}


install_vlc() {
  echo "installing VLC Media Player"
  sudo apt install -y vlc
  echo "VLC Media Player installed successfully."
}

install_gimp() {
  echo "installing GIMP"
  sudo apt install -y gimp
  echo "GIMP installed successfully."
}

install_obs() {
  echo "installing OBS Studio"
  sudo apt install -y ffmpeg
  sudo add-apt-repository ppa:obsproject/obs-studio
  sudo apt update
  sudo apt install -y obs-studio
  echo "OBS Studio installed successfully."
}

install_slack() {
  echo "installing Slack"
  wget https://downloads.slack-edge.com/linux_releases/slack-desktop-4.26.0-amd64.deb
  sudo dpkg -i slack-desktop-4.26.0-amd64.deb
  sudo apt --fix-broken install
  rm slack-desktop-4.26.0-amd64.deb
  echo "Slack installed successfully."
}

install_zoom() {
  echo "installing Zoom"
  wget https://zoom.us/client/latest/zoom_amd64.deb
  sudo dpkg -i zoom_amd64.deb
  sudo apt --fix-broken install
  rm zoom_amd64.deb
  echo "Zoom installed successfully."
}


install_zsh() {
  echo "installing Zsh"
  sudo apt install -y zsh
  echo "Zsh installed successfully."
}

install_oh_my_zsh() {
  echo "installing Oh My Zsh"
  sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
  echo "Oh My Zsh installed successfully."
}

install_tmux() {
  echo "installing tmux"
  sudo apt install -y tmux
  echo "tmux installed successfully."
}

install_htop() {
  echo "installing htop"
  sudo apt install -y htop
  echo "htop installed successfully."
}

install_neofetch() {
  echo "installing neofetch"
  sudo apt install -y neofetch
  echo "neofetch installed successfully."
}

install_ffmpeg() {
  echo "installing ffmpeg"
  sudo apt install -y ffmpeg
  echo "ffmpeg installed successfully."
}

install_nmap() {
  echo "installing nmap"
  sudo apt install -y nmap
  echo "nmap installed successfully."
}

install_wireshark() {
  echo "installing Wireshark"
  sudo apt install -y wireshark
  sudo dpkg-reconfigure wireshark-common
  sudo usermod -a -G wireshark $USER
  echo "Wireshark installed successfully."
}

install_virtualbox() {
  echo "installing VirtualBox"
  wget -q https://www.virtualbox.org/download/oracle_vbox_2016.asc -O- | sudo apt-key add -
  echo "deb [arch=amd64] https://download.virtualbox.org/virtualbox/debian $(lsb_release -sc) contrib" | sudo tee /etc/apt/sources.list.d/virtualbox.list
  sudo apt update
  sudo apt install -y virtualbox-6.1
  echo "VirtualBox installed successfully."
}

install_thunderbird() {
  echo "installing Thunderbird"
  sudo apt install -y thunderbird
  echo "Thunderbird installed successfully."
}

install_nmap() {
  echo "installing Nmap"
  sudo apt-get update
  sudo apt-get install -y nmap
  nmap --version
  echo "Nmap installed successfully."
}

install_metasploit() {
  echo "installing Metasploit"
  sudo apt-get update
  sudo apt-get install -y metasploit-framework
  echo "Metasploit installed successfully."
}

install_aircrack() {
  echo "installing Aircrack-ng"
  sudo apt-get update
  sudo apt-get install -y aircrack-ng
  echo "Aircrack-ng installed successfully."
}

install_hydra() {
  echo "installing Hydra"
  sudo apt-get update
  sudo apt-get install -y hydra
  echo "Hydra installed successfully."
}

install_john() {
  echo "installing John the Ripper"
  sudo apt-get update
  sudo apt-get install -y john
  john --test
  echo "John the Ripper installed successfully."
}

install_sqlmap() {
  echo "installing SQLmap"
  sudo apt-get update
  sudo apt-get install -y sqlmap
  echo "SQLmap installed successfully."
}

install_maltego() {
  echo "installing Maltego"
  wget https://www.paterva.com/malv4/community/MaltegoCE.v4.2.14.14004.deb
  sudo dpkg -i MaltegoCE.v4.2.14.14004.deb
  rm MaltegoCE.v4.2.14.14004.deb
  echo "Maltego installed successfully."
}

install_social_engineer_toolkit() {
  echo "installing the Social Engineer Toolkit (SET)"
  sudo apt-get update
  sudo apt-get install -y git python3-pip
  git clone https://github.com/trustedsec/social-engineer-toolkit/ /opt/set/
  cd /opt/set/
  pip3 install -r requirements.txt
  echo "SET installed successfully."
}

install_openvas() {
  echo "installing OpenVAS"
  sudo apt-get update
  sudo apt-get install -y openvas
  sudo systemctl start openvas-scanner
  sudo systemctl start openvas-manager
  sudo systemctl enable openvas-scanner
  sudo systemctl enable openvas-manager
  echo "OpenVAS installed successfully."
}

install_theharvester() {
  echo "installing TheHarvester"
  sudo apt-get update
  sudo apt-get install -y theharvester
  echo "TheHarvester installed successfully."
}

install_reconng() {
  echo "installing Recon-ng"
  sudo apt-get update
  sudo apt-get install -y recon-ng
  echo "Recon-ng installed successfully."
}

install_osintframework() {
  echo "installing OSINT Framework"
  git clone https://github.com/lockfale/OSINT-Framework.git /opt/osint/
  echo "OSINT Framework installed successfully."
}

install_spiderfoot() {
  echo "installing SpiderFoot"
  sudo apt-get update
  sudo apt-get install -y spiderfoot
  echo "SpiderFoot installed successfully."
}

install_shodan() {
  echo "installing Shodan"
  pip install shodan
  echo "Shodan installed successfully."
}

install_censys() {
  echo "installing Censys"
  pip install censys
  echo "Censys installed successfully."
}

install_theeye() {
  echo "installing The Eye"
  sudo apt-get update
  sudo apt-get install -y python-pip
  pip install theeye
  echo "The Eye installed successfully."
}

install_datasploit() {
  echo "installing Datasploit"
  git clone https://github.com/DataSploit/datasploit.git /opt/datasploit/
  cd /opt/datasploit/
  ./install.sh
  echo "Datasploit installed successfully."
}

install_sublist3r() {
  echo "installing Sublist3r"
  git clone https://github.com/aboul3la/Sublist3r.git /opt/sublist3r/
  cd /opt/sublist3r/
  pip install -r requirements.txt
  echo "Sublist3r installed successfully."
}

install_golismero() {
  echo "installing Golismero"
  sudo apt-get update
  sudo apt-get install -y golismero
  echo "Golismero installed successfully."
}

install_youtube_dl() {
  echo "installing youtube-dl"
  sudo curl -L https://yt-dl.org/downloads/latest/youtube-dl -o /usr/local/bin/youtube-dl
  sudo chmod a+rx /usr/local/bin/youtube-dl
  echo "youtube-dl installed successfully."
}

install_gcc() {
  echo "installing GCC"
  sudo apt-get update
  sudo apt-get install -y gcc
  echo "GCC installed successfully."
}

install_github_cli() {
  echo "installing GitHub CLI"
  sudo apt-get update
  sudo apt-get install -y gh
  echo "GitHub CLI installed successfully."
}

install_steam() {
  echo "installing Steam"
  sudo apt-get update
  sudo apt-get install -y steam-devices
  echo "Steam installed successfully."
}

install_wine() {
  echo "installing Wine"
  sudo apt-get update
  sudo apt-get install -y wine-stable
  echo "Wine installed successfully."
}

install_krita() {
  echo "installing Krita"
  sudo apt-get update
  sudo apt-get install -y krita
  echo "Krita installed successfully."
}

install_blender() {
  echo "installing Blender"
  sudo apt-get update
  sudo apt-get install -y blender
  echo "Blender installed successfully."
}

install_audacity() {
  echo "installing Audacity"
  sudo apt-get update
  sudo apt-get install -y audacity
  echo "Audacity installed successfully."
}

install_inkscape() {
  echo "installing Inkscape"
  sudo apt-get update
  sudo apt-get install -y inkscape
  echo "Inkscape installed successfully."
}

install_gparted() {
  echo "installing Gparted"
  sudo apt-get update
  sudo apt-get install -y gparted
  echo "Gparted installed successfully."
}

install_clementine() {
  echo "installing Clementine"
  sudo apt-get update
  sudo apt-get install -y clementine
  echo "Clementine installed successfully."
}

install_ardour() {
  echo "installing Ardour"
  sudo apt-get update
  sudo apt-get install -y ardour
  echo "Ardour installed successfully."
}

install_lmms() {
  echo "installing LMMS"
  sudo apt-get update
  sudo apt-get install -y lmms
  echo "LMMS installed successfully."
}

install_rosegarden() {
  echo "installing Rosegarden"
  sudo apt-get update
  sudo apt-get install -y rosegarden
  echo "Rosegarden installed successfully."
}

install_qtractor() {
  echo "installing Qtractor"
  sudo apt-get update
  sudo apt-get install -y qtractor
  echo "Qtractor installed successfully."
}

install_musescore() {
  echo "installing MuseScore"
  sudo apt-get update
  sudo apt-get install -y musescore
  echo "MuseScore installed successfully."
}

update_and_clean_raspi() {
    # Update package list and upgrade installed packages
    sudo apt-get update
    sudo apt-get upgrade -y

    # Check for a newer version of the OS and update if available
    CURRENT_VERSION=$(cat /etc/os-release | grep VERSION_ID | cut -d= -f2)
    NEWER_VERSION=$(sudo apt-get -s dist-upgrade | grep "^Inst" | grep -i raspberry | awk '{print $4}' | sort -V | tail -n 1)
    if [[ $NEWER_VERSION > $CURRENT_VERSION ]]; then
        echo "A newer version of the OS is available. Updating..."
        sudo apt-get dist-upgrade -y
        sudo reboot
    else
        echo "The OS is up-to-date."
    fi

    # Remove unnecessary packages and clean package cache
    sudo apt-get autoremove -y
    sudo apt-get autoclean -y

    # Update Raspberry Pi firmware
    sudo rpi-update -y

    # Check for broken dependencies
    sudo apt-get check

    echo "Raspberry Pi updated successfully."
}


install_all_music(){
    install_clementine
    install_ardour
    install_lmms
    install_rosegarden
    install_qtractor
    install_musescore
    echo "All music packages installed successfully."
}

install_dev() {
  install_python
  install_conda
  install_go
  install_node_npm
  install_pnpm
  install_yarn
  install_git
  install_docker
  install_postgresql
  install_redis
  install_nginx
  install_vscode
  install_jdk
  install_maven
  install_gradle
  install_ruby
  install_rails
  install_elasticsearch
  install_firebase
  install_vercel
  install_r_rstudio
  install_mysql
  install_mongodb
  install_apache
  install_php
  install_dotnet_sdk
  install_rust
  install_zsh
  install_oh_my_zsh
  install_tmux 
  install_htop
  install_neofetch
  install_ffmpeg 
  install_gcc
  install_github_cli
  echo "All development packages installed successfully."
}

install_cyber(){
    install_metasploit
    install_aircrack
    install_hydra
    install_john
    install_sqlmap
    install_maltego
    install_social_engineer_toolkit
    install_openvas
    install_theharvester
    install_reconng
    install_osintframework
    install_spiderfoot
    install_shodan
    install_censys
    install_theeye
    install_datasploit
    install_sublist3r
    install_golismero
    echo "All cyber packages installed successfully."
}

install_fun(){
    install_chrome
    install_chromedriver
    install_spotify
    install_vlc
    install_gimp
    install_obs
    install_slack
    install_zoom
    install_discord
    install_youtube_dl
    install_steam
    install_wine
    install_krita
    install_blender
    install_audacity
    install_inkscape
    install_gparted
    install_clementine
    echo "All fun packages installed successfully."
}

install_all() {
    install_dev
    install_cyber
    install_fun
    install_all_music

  echo "All packages installed successfully."
}

#!/bin/bash

# Utility functions
list_length() {
  echo "$#"
}

list_get() {
  local index=$1
  shift
  echo "${!index}"
}

spinner() {
  local delay=0.1
  local spinstr='|/-\'
  local temp
  printf " Installing... "
  while true; do
    temp=${spinstr#?}
    printf "[%c]" "$spinstr"
    spinstr=$temp${spinstr%"$temp"}
    sleep $delay
    printf "\b\b\b"
  done
  printf "\n"
}

draw_header_simple() {
  echo -e "\033[1;34m"
  echo "============================================="
  echo "         Welcome to Software Installer       "
  echo "                 Version 1.0                 "
  echo "============================================="
  echo -e "\033[0m"
}

# Draw progress bar
# Arguments: current progress (0-100), total width of the progress bar
draw_progress_bar() {
  local _progress=$1
  local _width=$2
  local _filled=$(($_width * $_progress / 100))
  local _empty=$(($_width - $_filled))

  printf "["
  printf "%${_filled}s" '' | tr ' ' '#'
  printf "%${_empty}s" '' | tr ' ' ' '
  printf "] %3d%%" $_progress
}

# Package information function
# Arguments: package name
package_info() {
  local package_name=$1
  # Here, you can add package information like description, version, and installation size
  # based on the package_name variable.
  echo "Package Information: $package_name"
}

# Key handling function for help menu
help_key_handler() {
  while true; do
    local key
    read -rsn1 key
    case $key in
      q|Q|'') break ;;
      *) continue ;;
    esac
  done
}

# Help menu function
show_help() {
  tput clear
  echo "Help Menu"
  echo "========="
  echo "Arrow keys (up and down): Navigate through categories/packages"
  echo "Enter: Select category/package"
  echo "Spacebar: Select/deselect package for installation"
  echo "a: Select all packages"
  echo "d: Deselect all packages"
  echo "i: Start the installation process"
  echo "q, Q, or Esc: Exit the application"
  echo "?: Display help information"
  echo ""
  echo "Press 'q' or 'Q' to close the help menu."

  help_key_handler
}

# Color schemes function
set_color_scheme() {
  local scheme=$1

  case $scheme in
    1) # Default color scheme
      export CATEGORY_SELECTED_BG="4"
      export CATEGORY_SELECTED_FG="7"
      export PACKAGE_SELECTED_BG="4"
      export PACKAGE_SELECTED_FG="7"
      export PACKAGE_CHECKED_FG="2"
      ;;
    2) # Alternative color scheme
      export CATEGORY_SELECTED_BG="2"
      export CATEGORY_SELECTED_FG="0"
      export PACKAGE_SELECTED_BG="2"
      export PACKAGE_SELECTED_FG="0"
      export PACKAGE_CHECKED_FG="1"
      ;;
    # Add more color schemes here
  esac
}

# Set the default color scheme
set_color_scheme 1

select_from_menu() {
  local menu_items=("$@")
local current_index=0
local key

while true; do
tput clear
draw_header
for i in "${!menu_items[@]}"; do
if [[ $i -eq $current_index ]]; then
tput setaf $CATEGORY_SELECTED_FG
tput setab $CATEGORY_SELECTED_BG
fi

  echo "${menu_items[$i]}"

  tput sgr0
done

read -rsn3 key
case $key in
  $'\x1B[A') ((current_index--)) ;;
  $'\x1B[B') ((current_index++)) ;;
  $'\x0A') break ;;
  $'\x1B') exit 0 ;;
  '?') show_help ;;
esac

((current_index < 0)) && current_index=0
((current_index >= ${#menu_items[@]})) && current_index=$((${#menu_items[@]} - 1))
menu_items=("$@")
local current_index=0
local key

while true; do
tput clear
draw_header
for i in "${!menu_items[@]}"; do
if [[ $i -eq $current_index ]]; then
tput setaf $CATEGORY_SELECTED_FG
tput setab $CATEGORY_SELECTED_BG
fi

bash
Copy code
  echo "${menu_items[$i]}"

  tput sgr0
done

read -rsn3 key
case $key in
  $'\x1B[A') ((current_index--)) ;;
  $'\x1B[B') ((current_index++)) ;;
  $'\x0A') break ;;
  $'\x1B') exit 0 ;;
  '?') show_help ;;
esac

((current_index < 0)) && current_index=0
((current_index >= ${#menu_items[@]})) && current_index=$((${#menu_items[@]} - 1))
done

echo $current_index
}

select_packages() {
local menu_items=("$@")
local current_index=0
local key
local selected_indexes=()

while true; do
tput clear
draw_header
for i in "${!menu_items[@]}"; do
if [[ " ${selected_indexes[*]} " =~ " $i " ]]; then
tput setaf $PACKAGE_CHECKED_FG
echo -n "[x] "
else
echo -n "[ ] "
fi

  if [[ $i -eq $current_index ]]; then
    tput setaf $PACKAGE_SELECTED_FG
    tput setab $PACKAGE_SELECTED_BG
  fi

  echo "${menu_items[$i]}"
  tput sgr0
done

# Display package information
tput cup $((${#menu_items[@]} + 1)) 0
package_info "${menu_items[$current_index]}"

read -rsn3 key
case $key in
  $'\x1B[A') ((current_index--)) ;;
  $'\x1B[B') ((current_index++)) ;;
  $'\x20')
    if [[ " ${selected_indexes[*]} " =~ " $current_index " ]]; then
      selected_indexes=(${selected_indexes[@]/$current_index})
    else
      selected_indexes+=("$current_index")
    fi
    ;;
  $'\x0A') break ;;
  $'\x1B') exit 0 ;;
  '?') show_help ;;
esac

((current_index < 0)) && current_index=0
((current_index >= ${#menu_items[@]})) && current_index=$((${#menu_items[@]} - 1))
done

echo "${selected_indexes[@]}"
}

install_selected_packages() {
local selected_indexes=("$@")
local packages=("${!2}")
for index in "${selected_indexes[@]}"; do
if [[ ${packages[$index]} != "Back" ]]; then
echo "Installing ${packages[$index]/// }"
spinner & ${packages[$index]}
kill $! 2>/dev/null
echo "Installed ${packages[$index]/// }"
else
break
fi
done
}

check_prerequisites() {

Check if prerequisites are already installed
if [[ -x "$(command -v curl)" ]] && [[ -x "$(command -v gcc)" ]] && [[ -x "$(command -v make)" ]] && [[ -x "$(command -v openssl)" ]]; then
echo 0
else
echo 1
fi
}

draw_header() {
tput setaf $HEADER_FG
tput bold
echo "████████╗██╗ ██╗███████╗██╗ ███████╗"
echo "╚══██╔══╝██║ ██║██╔════╝██║ ██╔════╝"
echo " ██║ ███████║█████╗ ██║ █████╗ "
echo " ██║ ██╔══██║██╔══╝ ██║ ██╔══╝ "
echo " ██║ ██║ ██║███████╗███████╗███████╗"
echo " ╚═╝ ╚═╝ ╚═╝╚══════╝╚══════╝╚══════╝"
echo " Package Installer v1.0"
echo " Easily install software packages from multiple categories."
echo ""
tput sgr0
}

package_info() {
local package_name="$1"
echo "Package: ${package_name//_/ }"

Display package information based on the selected package
Example:
echo "Version: 1.0.0"
echo "Description: A brief description of the package."
echo "Size: 100 MB"
}

show_help() {
tput clear
draw_header
echo "Help Information"
echo "----------------"
echo "Use the arrow keys to navigate through the menus."
echo "Press Enter to select a category or package."
echo "Press Spacebar to select/deselect packages for installation."
echo "Press 'q' or 'Esc' to exit the application."
echo "Press 'a' to select all packages in a category."
echo "Press 'd' to deselect all packages in a category."
echo "Press 'i' to start the installation process."
echo ""
echo "Press any key to return to the menu..."
read -rsn1
}

main() {

Set up color variables
HEADER_FG=6
CATEGORY_SELECTED_FG=0
CATEGORY_SELECTED_BG=6
PACKAGE_SELECTED_FG=0
PACKAGE_SELECTED_BG=6
PACKAGE_CHECKED_FG=2

echo "Before menu, we must ensure pre-requisites are installed"

if [[ $(check_prerequisites) -eq 0 ]]; then
read -p "Prerequisites are already installed. Do you want to reinstall them? [y/n]: " answer
if [[ "$answer" == "y" ]]; then
echo "Installing pre-requisites. This may take a while..."
install_prerequisites
echo "Pre-requisites installed successfully."
else
echo "Skipping installation of pre-requisites."
fi
else
echo "Installing pre-requisites. This may take a while..."
install_prerequisites
echo "Pre-requisites installed successfully."
fi

local categories=("Development" "Cyber" "Fun" "Music" "Install All" "Exit")
local music_packages=("install_clementine" "install_ardour" "install_lmms" "install_rosegarden" "install_qtractor" "install_musescore" "Back")
local dev_packages=("install_python" "install_conda" "install_go" "install_node_npm" "install_pnpm" "install_yarn" "install_git" "install_docker" "install_postgresql" "install_redis" "install_nginx" "install_vscode" "install_jdk" "install_maven" "install_gradle" "install_ruby" "install_rails" "install_elasticsearch" "install_firebase" "install_vercel" "install_r_rstudio" "install_mysql" "install_mongodb" "install_apache" "install_php" "install_dotnet_sdk" "install_rust" "install_zsh" "install_oh_my_zsh" "install_tmux" "install_htop" "install_neofetch" "install_ffmpeg" "install_gcc" "install_github_cli" "Back")
local cyber_packages=("install_metasploit" "install_aircrack" "install_hydra" "install_john" "install_sqlmap" "install_maltego" "install_social_engineer_toolkit" "install_openvas" "install_theharvester" "install_reconng" "install_osintframework" "install_spiderfoot" "install_shodan" "install_censys" "install_theeye" "install_datasploit" "install_sublist3r" "install_golismero" "Back")
local fun_packages=("install_chrome" "install_chromedriver" "install_spotify" "install_vlc" "install_gimp" "install_obs" "install_slack" "install_zoom" "install_discord" "install_youtube_dl" "install_steam" "install_wine" "install_krita" "install_blender" "install_audacity" "install_inkscape" "install_gparted" "install_clementine" "Back")

while true; do
tput clear
draw_header
local category_index=$(select_from_menu "${categories[@]}")
case $category_index in
0) # Development
local selected_indexes=$(select_packages "${dev_packages[@]}")
install_selected_packages "${selected_indexes[@]}" dev_packages
;;
1) # Cyber
local selected_indexes=$(select_packages "${cyber_packages[@]}")
install_selected_packages "${selected_indexes[@]}" cyber_packages
;;
2) # Fun
local selected_indexes=$(select_packages "${fun_packages[@]}")
install_selected_packages "${selected_indexes[@]}" fun_packages
;;
3) # Music
local selected_indexes=$(select_packages "${music_packages[@]}")
install_selected_packages "${selected_indexes[@]}" music_packages
;;
4) # Install All
install_all_music
install_dev
install_cyber
install_fun
echo "All packages installed successfully."
;;
5) # Exit
exit 0
;;
esac
done
}

main





