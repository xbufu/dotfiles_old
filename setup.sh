#!/bin/bash

PATH=$PATH:$HOME/.local/bin:/usr/local/go/bin:$HOME/go/bin

sudo apt update && sudo apt upgrade -y && sudo apt autoremove -y && sudo apt autoclean -y

# Basic tools
sudo apt install -y curl wget tmux neovim manpages-dev manpages-posix-dev libssl-dev libffi-dev build-essential openssl gnupg mlocate xclip dkms linux-headers-amd64 htop libmpc-dev

# Change shell to bash
chsh
sudo apt -y purge zsh

# Set up git
sudo apt install -y git
git config --global pull.rebase true
read -p "Enter git username: " git_user
git config --global user.name "$git_user"
read -p "Enter git email: " git_email
git config --global user.email "$git_email"
git config --global init.defaultBranch main
ssh -T git@github.com

# Set up config files
ln ~/dotfiles/.bash_aliases ~/.bash_aliases
ln ~/dotfiles/.vimrc ~/.vimrc
ln ~/dotfiles/.tmux.conf ~/.tmux.conf
mkdir -p ~/.config/tmux
ln ~/dotfiles/vpn.sh ~/.config/tmux/vpn.sh
mkdir ~/.git_update
ln ~/dotfiles/git_update.sh ~/.git_update/git_update.sh
chmod +x ~/.git_update/git_update.sh
echo -e "\n# Git update script\n0 8 * * 7\t$USER\t$HOME/.git_update/git_update.sh" | sudo tee -a /etc/crontab

# Disable terminal beep
echo "blacklist pcspkr" | sudo tee /etc/modprobe.d/nobeep.conf
echo -e "\n# Turn off beep\nxset b off" | sudo tee -a /etc/profile

# Disable login message
touch ~/.hushlogin

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

# Recon tools

# Set up rustscan
wget https://github.com/RustScan/RustScan/releases/download/2.0.1/rustscan_2.0.1_amd64.deb -O ~/rustscan_2.0.1_amd64.deb
sudo apt install -y ~/rustscan_2.0.1_amd64.deb
rm -f ~/rustscan_2.0.1_amd64.deb

# Install gobuster
sudo apt install -y gobuster

# Set up feroxbuster
cd ~
wget https://github.com/epi052/feroxbuster/releases/download/v2.0.0/feroxbuster_amd64.deb.zip -O ~/feroxbuster_amd64.deb.zip
unzip ~/feroxbuster_amd64.deb.zip
sudo apt install -y ~/feroxbuster_2.0.0_amd64.deb
rm -f ~/feroxbuster_2.0.0_amd64.deb ~/feroxbuster_amd64.deb.zip

# Set up AutoRecon
sudo apt install -y seclists curl enum4linux gobuster nbtscan nikto nmap onesixtyone oscanner smbclient smbmap smtp-user-enum snmp sslscan sipvicious tnscmd10g whatweb wkhtmltopdf
pipx install git+https://github.com/Tib3rius/AutoRecon.git

# Set up enum4linux-ng
sudo apt install -y smbclient python3-ldap3 python3-yaml python3-impacket
git clone https://github.com/cddmp/enum4linux-ng.git /opt/enum4linux-ng
cd /opt/enum4linux-ng
python3 -m pip install -r requirements.txt
sudo ln -s /opt/enum4linux-ng/enum4linux-ng.py /usr/bin/enum4linux-ng
cd ~

# GitTools
git clone https://github.com/internetwache/GitTools /opt/GitTools

# ffuf
go get -u https://github.com/ffuf/ffuf

# BE & RE
python3 -m pip install pwntools
sudo apt install -y gdb
pip3 install capstone
pip3 install unicorn
pip3 install keystone-engine
pip3 install ropper
git clone https://github.com/hugsy/gef.git /opt/gef
echo 'source /opt/gef/gef.py' >> ~/.gdbinit
echo 'set disassembly-flavor intel' >> ~/.gdbinit

# Set up Ghidra
wget https://ghidra-sre.org/ghidra_9.2.2_PUBLIC_20201229.zip -O ~/ghidra_9.2.2.zip
unzip ~/ghidra_9.2.2.zip
mv ~/ghidra_9.2.2_PUBLIC /opt/ghidra
rm -f ~/ghidra_9.2.2.zip
sudo ln -s /opt/ghidra/ghidraRun /usr/bin/ghidra
git clone https://github.com/zackelia/ghidra-dark /opt/ghidra-dark

# Install radare2 and cutter
sudo apt install -y radare2 radare2-cutter

# Crypto
pipx install name-that-hash
pipx install stegcracker
sudo apt install -y binwalk exiftool steghide xxd ghex
git clone https://github.com/Ganapati/RsaCtfTool /opt/RsaCtfTool
python3 -m pip install -r /opt/RsaCtfTool/requirements.txt

# PrivEsc
# Linux
git clone https://github.com/andrew-d/static-binaries.git /opt/static-binaries
git clone https://github.com/rebootuser/LinEnum.git /opt/LinEnum
git clone https://github.com/jondonas/linux-exploit-suggester-2 /opt/linux-exploit-suggester-2
git clone https://github.com/Anon-Exploiter/SUID3NUM /opt/SUID3NUM
git clone https://github.com/carlospolop/privilege-escalation-awesome-scripts-suite /opt/privilege-escalation-awesome-scripts-suite
mkdir /opt/pspy
cd /opt/pspy
wget https://github.com/DominicBreuker/pspy/releases/download/v1.2.0/pspy32
wget https://github.com/DominicBreuker/pspy/releases/download/v1.2.0/pspy32s
wget https://github.com/DominicBreuker/pspy/releases/download/v1.2.0/pspy64
wget https://github.com/DominicBreuker/pspy/releases/download/v1.2.0/pspy64s
cd ~

# Windows
git clone https://github.com/samratashok/nishang /opt/nishang
git clone https://github.com/PowerShellMafia/PowerSploit /opt/PowerSploit
git clone https://github.com/bitsadmin/wesng /opt/wesng
python3 -m pip install /opt/wesng

# Set up script folder for easy access
mkdir ~/PrivEsc
ln -s /opt/LinEnum/LinEnum.sh ~/PrivEsc/linenum.sh
ln -s /opt/linux-exploit-suggester-2/linux-exploit-suggester-2.pl ~/PrivEsc/les2.pl
ln -s /opt/SUID3NUM/suid3num.py ~/PrivEsc/suidenum.py
ln -s /opt/pspy/pspy32 ~/PrivEsc/pspy32
ln -s /opt/pspy/pspy32s ~/PrivEsc/pspy32s
ln -s /opt/pspy/pspy64 ~/PrivEsc/pspy64
ln -s /opt/pspy/pspy64s ~/PrivEsc/pspy64s
ln -s /opt/privilege-escalation-awesome-scripts-suite/linPEAS/linpeas.sh ~/PrivEsc/linpeas.sh
ln -s /opt/privilege-escalation-awesome-scripts-suite/winPEAS/winPEASbat/winPEAS.bat ~/PrivEsc/winpeas.bat
ln -s /opt/privilege-escalation-awesome-scripts-suite/winPEAS/winPEASexe/winPEAS/bin/x64/Release/winPEAS.exe ~/PrivEsc/winpeas64.exe
ln -s /opt/privilege-escalation-awesome-scripts-suite/winPEAS/winPEASexe/winPEAS/bin/x86/Release/winPEAS.exe ~/PrivEsc/winpeas32.exe
ln -s /opt/static-binaries/binaries/linux/x86_64/ncat ~/PrivEsc/nc

# Final update and clean up
sudo apt update && sudo apt upgrade -y && sudo apt autoremove -y && sudo apt autoclean -y

echo -e "To enable dark mode theme for ghidra run it once and close it. Then run the following command:\n"
echo -e "\t python3 /opt/ghidra-dark/install.py --path /opt/ghidra"
