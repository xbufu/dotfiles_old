#!/bin/bash

export PATH="$PATH:$HOME/.local/bin"

sudo apt update && sudo apt upgrade -y && sudo apt autoremove -y && sudo apt autoclean -y

sudo apt install -y curl wget tmux vim manpages-dev manpages-posix-dev libssl-dev libffi-dev build-essential openssl gnupg mlocate xclip dkms linux-headers-`uname -r` htop libmpc-dev gnome-tweaks gnome-shell-extensions chrome-gnome-shell nmap gdebi vlc

# Git
sudo apt install -y git
git config --global pull.rebase true
read -p "Enter git username: " git_user
git config --global user.name "$git_user"
read -p "Enter git email: " git_email
git config --global user.email "$git_email"
git config --global init.defaultBranch main
ssh -T git@github.com

# Personal repos
git clone git@github.com:xbufu/RPL.git ~/RPL
git clone git@github.com:xbufu/LearnCodeTheHardWay.git ~/LearnCodeTheHardWay

# Config files
ln ~/dotfiles/.bash_aliases ~/.bash_aliases
ln ~/dotfiles/.vimrc ~/.vimrc
ln ~/dotfiles/.tmux.conf ~/.tmux.conf
mkdir -p ~/.config/tmux
ln ~/dotfiles/vpn.sh ~/.config/tmux/vpn.sh
ln ~/dotfiles/.themes ~/.themes
ln ~/dotfiles/.icons ~/.icons

# Python3
sudo apt install -y python3 python3-pip python3-dev
python3 -m pip install setuptools
python3 -m pip install wheel 

# Python2
sudo apt install -y python2
curl https://bootstrap.pypa.io/2.7/get-pip.py -o ~/get-pip.py
python2 ~/get-pip.py
rm -f ~/get-pip.py
python2 -m pip install setuptools
python2 -m pip install wheel

# pipx
sudo apt install -y python3-venv
python3 -m pip install --user pipx
python3 -m pipx ensurepath
read -n 1 -p "Append $HOME/.local/bin to secure_path (ENTER to continue):"
sudo visudo /etc/sudoers

# Java
sudo apt install -y openjdk-11-jdk openjdk-11-jre openjdk-11-dbg openjdk-11-doc
echo -e "\n# Java\nexport JAVA_HOME=/usr/lib/jvm/java-11-openjdk-amd64" >> ~/.bashrc
echo -e "export PATH=\$PATH:\$JAVA_HOME/bin" >> ~/.bashrc

# Go
wget https://golang.org/dl/go1.15.8.linux-amd64.tar.gz -O ~/go1.15.8.linux-amd64.tar.gz
sudo tar -C /usr/local -xzf ~/go1.15.8.linux-amd64.tar.gz
rm -f ~/go1.15.8.linux-amd64.tar.gz
echo -e "\n# GoLang\nexport PATH=\$PATH:/usr/local/go/bin:\$HOME/go/bin" >> ~/.bashrc

# Rust
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh

# Haskell
sudo apt install -y haskell-platform

# AutoKey
wget https://github.com/autokey/autokey/releases/download/v0.95.10/autokey-gtk_0.95.10-0_all.deb -O ~/autokey-gtk_0.95.10-0_all.deb
wget https://github.com/autokey/autokey/releases/download/v0.95.10/autokey-common_0.95.10-0_all.deb -O ~/autokey-common_0.95.10-0_all.deb
VERSION="0.95.10-0"
sudo dpkg --install autokey-common_${VERSION}_all.deb autokey-gtk_${VERSION}_all.deb
sudo apt -y --fix-broken install
python3 -m pip install pynput
mkdir -p ~/.config/autokey/data/personal
cp ~/dotfiles/autokey/tmux.py ~/dotfiles/autokey/.tmux.json ~/.config/autokey/data/personal/

# Email
sudo apt install -y thunderbird
wget https://protonmail.com/download/bridge/protonmail-bridge_1.6.3-1_amd64.deb -O ~/protonmail-bridge_1.6.3-1_amd64.deb
sudo gdebi ~/protonmail-bridge_1.6.3-1_amd64.deb
rm -f ~/protonmail-bridge_1.6.3-1_amd64.deb

# VPN
sudo apt install -y openvpn
wget -q -O - https://repo.protonvpn.com/debian/public_key.asc | sudo apt-key add -
sudo add-apt-repository 'deb https://repo.protonvpn.com/debian unstable main'
sudo apt update && sudo apt install -y protonvpn

# Noise Torch
echo -e '\nexport PATH="$PATH:$HOME/.local/bin"' >> ~/.bashrc
wget https://github.com/lawl/NoiseTorch/releases/download/0.10.1/NoiseTorch_x64.tgz -O ~/NoiseTorch_x64.tgz
tar -C $HOME -xzf ~/NoiseTorch_x64.tgz
gtk-update-icon-cache
sudo setcap 'CAP_SYS_RESOURCE=+ep' ~/.local/bin/noisetorch
rm -f ~/NoiseTorch_x64.tgz

# Discord
 wget -O ~/discord.deb "https://discordapp.com/api/download?platform=linux&format=deb"
 sudo gdebi ~/discord.deb
 rm -f ~/discord.deb

# OBS
sudo apt -y install ffmpeg
sudo add-apt-repository ppa:obsproject/obs-studio
sudo apt update
sudo apt install -y obs-studio

# VMWare
wget https://download3.vmware.com/software/wkst/file/VMware-Workstation-Full-16.1.0-17198959.x86_64.bundle -O ~/VMware-Workstation-Full-16.1.0-17198959.x86_64.bundle
chmod +x ~/VMware-Workstation-Full-16.1.0-17198959.x86_64.bundle
sudo ~/VMware-Workstation-Full-16.1.0-17198959.x86_64.bundle
rm -f ~/VMware-Workstation-Full-16.1.0-17198959.x86_64.bundle

# Jetbrains
wget https://download.jetbrains.com/toolbox/jetbrains-toolbox-1.20.7940.tar.gz -O ~/jetbrains-toolbox-1.20.7940.tar.gz
TOOLBOX_TEMP_DIR=$(mktemp -d)
tar -C "$TOOLBOX_TEMP_DIR" -xf ~/jetbrains-toolbox-1.20.7940.tar.gz
rm -f ~/jetbrains-toolbox-1.20.7940.tar.gz
"$TOOLBOX_TEMP_DIR"/*/jetbrains-toolbox
rm -rf "$TOOLBOX_TEMP_DIR"

# insync
wget https://d2t3ff60b2tol4.cloudfront.net/builds/insync_3.3.6.40933-focal_amd64.deb -O ~/insync_3.3.6.40933-focal_amd64.deb
sudo gdebi ~/insync_3.3.6.40933-focal_amd64.deb
rm -f ~/insync_3.3.6.40933-focal_amd64.deb

# Zoom
wget https://zoom.us/client/latest/zoom_amd64.deb -O ~/zoom_amd64.deb
sudo gdebi ~/zoom_amd64.deb
rm -f ~/zoom_amd64.deb

# 7z
sudo add-apt-repository universe
sudo apt update
sudo apt -y install p7zip-full p7zip-rar

# Teamspeak
wget https://files.teamspeak-services.com/releases/client/3.5.6/TeamSpeak3-Client-linux_amd64-3.5.6.run -O ~/TeamSpeak3-Client-linux_amd64-3.5.6.run
chmod +x ~/TeamSpeak3-Client-linux_amd64-3.5.6.run
~/TeamSpeak3-Client-linux_amd64-3.5.6.run

# TeamViewer
wget https://download.teamviewer.com/download/linux/teamviewer_amd64.deb -O ~/teamviewer_amd64.deb
sudo gdebi ~/teamviewer_amd64.deb
rm -f ~/teamviewer_amd64.deb

# X2Go
sudo add-apt-repository ppa:x2go/stable
sudo apt update
sudo apt-get install x2goclient

# Steam
sudo apt install steam

sudo apt update && sudo apt upgrade -y && sudo apt autoremove -y && sudo apt autoclean -y
