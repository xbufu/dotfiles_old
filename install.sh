#!/bin/bash

cd /home/bufu

sudo apt update && sudo apt upgrade -y 

# Install basic tools
sudo apt install -y curl wget git tmux neovim manpages-dev manpages-posix-dev libssl-dev libffi-dev build-essential openssl gnupg mlocate
sudo updatedb

# Configure git
git config --global user.email "xbufu@pm.me"
git config --global user.name "Bufu"

# Set up python2

sudo apt install -y python2
curl https://bootstrap.pypa.io/2.7/get-pip.py -o get-pip.py
python2 get-pip.py
rm -f get-pip.py
pip2 install setuptools
pip2 install wheel

# Set up python3

sudo apt install -y python3 python3-pip python3-dev pipx python3-venv
python3 -m pipx ensurepath
pipx install virtualenv
pip3 install setuptools
pip3 install wheel

# Set up java

sudo apt install -y openjdk-11-jdk openjdk-11-jre openjdk-11-dbg openjdk-11-doc

# Gnome extensions

sudo apt install -y gnome-tweaks gnome-shell-extensions chrome-gnome-shell

# Set up Kali repositories

wget 'https://archive.kali.org/archive-key.asc'
sudo apt-key add archive-key.asc
rm -f archive-key.asc
sudo sh -c "echo 'deb https://http.kali.org/kali kali-rolling main non-free contrib' > /etc/apt/sources.list.d/kali.list"
sudo apt update
sudo sh -c "echo 'deb https://http.kali.org/kali kali-rolling main non-free contrib' > /etc/apt/sources.list.d/kali.list"
sudo apt update

# Recon tools

sudo apt install -y nmap enum4linux smbmap snmpcheck snmp-mibs-downloader seclists wireshark proxychains4
sudo download-mibs
sudo nvim /etc/snmp/snmp.conf
wget https://github.com/RustScan/RustScan/releases/download/2.0.1/rustscan_2.0.1_amd64.deb -O rustscan.deb
sudo apt install -y ./rustscan.deb

# WebApps
sudo apt install -y nikto gobuster sqlmap
wget https://github.com/epi052/feroxbuster/releases/download/v2.0.0/feroxbuster_amd64.deb.zip -O feroxbuster.zip
unzip feroxbuster.zip
sudo apt install ./feroxbuster_2.0.0_amd64.deb
rm -f feroxbuster_amd64.deb

# Password cracking
sudo apt install -y hydra john hashcat hashcat-utils hashid wordlists
pipx install name-that-hash

# Reversing and pwn
sudo apt install -y radare2 radare2-cutter
python3 -m pip install --upgrade pip
python3 -m pip install --upgrade pwntools
pip2 install capstone unicorn keystone-engine ropper
pip3 install capstone unicorn keystone-engine ropper
git clone https://github.com/hugsy/gef.git /opt/gef
echo 'source /opt/gef/gef.py' >> /home/bufu/.gdbinit
echo 'set disassembly-flavor intel' >> /home/bufu/.gdbinit
wget https://ghidra-sre.org/ghidra_9.2.2_PUBLIC_20201229.zip -O ghidra_9.2.2.zip
unzip ghidra_9.2.2.zip
mv ghidra_9.2.2_PUBLIC /opt/ghidra
sudo cp /opt/ghidra/ghidraRun /usr/bin/ghidra

# Exploitation
sudo apt install -y metasploit-framework msfpc
sudo msfdb init
sudo msfdb start
git clone https://github.com/offensive-security/exploit-database.git /opt/exploit-database.git
sudo apt update && sudo apt install -y exploitdb exploitdb-bin-sploits exploitdb-papers python3-pyexploitdb

# Crypto & forensics
sudo apt install -y binwalk exiftool steghide xxd ghex
pipx install stegcracker

# Personal github
ssh -T git@github.com
git clone git@github.com:xbufu/CySec.git /home/bufu/CySec
git clone git@github.com:xbufu/dotfiles.git /home/bufu/dotfiles
cp /home/bufu/dotfiles/.tmux.conf /home/bufu/
cp /home/bufu/dotfiles/.aliases /home/bufu/
mkdir -p /home/bufu/.config/nvim
cp /home/bufu/dotfiles/init.vim /home/bufu/.config/nvim/init.vim
git clone git@github.com:xbufu/LearnCodeTheHardWay.git /home/bufu/LearnCodeTheHardWay

# Other repositories
git clone https://github.com/internetwache/GitTools /opt/GitTools
git clone https://github.com/SecureAuthCorp/impacket.git /opt/impacket
pip3 install -r /opt/impacket/requirements.txt
pip3 install /opt/impacket
pip2 install argparse
pip2 install -r /opt/impacket/requirements.txt
pip2 install /opt/impacket
git clone https://github.com/rebootuser/LinEnum.git /opt/LinEnum
git clone https://github.com/jondonas/linux-exploit-suggester-2 /opt/linux-exploit/suggester-2
git clone https://github.com/samratashok/nishang /opt/nishang
git clone https://github.com/PowerShellMafia/PowerSploit /opt/PowerSploit
git clone https://github.com/carlospolop/privilege-escalation-awesome-scripts-suite /opt/privilege-escalation-awesome-scripts-suite
git clone https://github.com/DominicBreuker/pspy /opt/pspy
git clone https://github.com/Ganapati/RsaCtfTool /opt/RsaCtfTool
pip3 install -r /opt/RsaCtfTool/requirements.txt
git clone https://github.com/Anon-Exploiter/SUID3NUM /opt/SUID3NUM
git clone https://github.com/bitsadmin/wesng /opt/wesng
pip3 install -r /opt/wesng/requirements.txt

# Clean up
rm -f /home/bufu/ghidra_9.2.2.zip /home/bufu/feroxbuster_2.0.0_amd64.deb /home/bufu/feroxbuster_amd64.deb.zip /home/bufu/feroxbuster.zip /home/bufu/ghidra_9.2.2.zip /home/bufu/rustscan.deb
