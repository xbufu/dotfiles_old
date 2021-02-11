#!/bin/bash

# Fix PATH for pip
PATH=$PATH:$HOME/.local/bin

git_ssh_check() {
	if [ ! -f ~/.ssh/id_ed25519 ]; then
		printf "Please create SSH key first and add it to Github!\n"
		printf "Commands:\n"
		printf '\tssh-keygen -t ed25519 -C "your_email@example.com"\n'
		printf "\teval \`ssh-agent -s\`\n"
		printf "\tssh-add ~/.ssh/id_ed25519\n"
		exit
	fi
}

python_setup() {
	# Set up Python3
	sudo apt install -y python3 python3-dev python3-venv
	
	# Set up pip3
	sudo apt install -y python3-pip
	pip3 install setuptools
	pip3 install wheel
	pip3 install virtualenv
	pip3 install requests
	
	# Set up pipx
	python3 -m pip install --user pipx
	python3 -m pipx ensurepath
	read -n 1 -p "Append /home/$USER/.local/bin to secure_path (ENTER to continue):"
	sudo visudo /etc/sudoers
	echo -e "\n# pipx" >> ~/.bashrc
	echo -e "export PATH=\$PATH:\$HOME/.local/bin" >> ~/.bashrc
	echo -e "eval \"\$(register-python-argcomplete pipx)\"" >> ~/.bashrc

	# Set up Python2
	sudo apt install -y python2
	
	# Set up pip2
	curl https://bootstrap.pypa.io/2.7/get-pip.py -o get-pip.py
	python2 get-pip.py
	rm -f get-pip.py
	pip2 install setuptools
	pip2 install wheel
	pip2 install requests
	pip2 install argparse
}

java_setup() {
	# Set up Java
	sudo apt install -y openjdk-11-jdk openjdk-11-jre openjdk-11-dbg openjdk-11-doc
	echo -e "\n# Java\nexport JAVA_HOME=/usr/lib/jvm/java-11-openjdk-amd64" >> ~/.bashrc
	echo -e "\nexport PATH=\$PATH:\$JAVA_HOME/bin" >> ~/.bashrc
}

go_setup() {
	# Set up GoLang
	wget https://golang.org/dl/go1.15.8.linux-amd64.tar.gz -O go1.15.8.linux-amd64.tar.gz
	sudo tar -C /usr/local -xzf go1.15.8.linux-amd64.tar.gz
	rm -f go1.15.8.linux-amd64.tar.gz
	echo -e "\n# GoLang\nexport PATH=\$PATH:/usr/local/go/bin" >> ~/.bashrc
}

config_setup() {
	# Get config files 
	git clone git@github.com:xbufu/dotfiles.git ~/dotfiles
	
	# Get bash configs
	cp ~/dotfiles/.bashrc ~/.bashrc
	cp ~/dotfiles/.bash_aliases ~/.bash_aliases
	
	# Set up tmux config
	mkdir -p ~/.config/tmux
	cp ~/dotfiles/.tmux.conf ~/.tmux.conf
	cp ~/dotfiles/vpn.sh ~/.config/tmux/vpn.sh
	
	# Set up nvim config
	mkdir -p ~/.config/nvim
	cp ~/dotfiles/init.vim ~/.config/nvim/init.vim
	
	# Set up feroxbuster config
	mkdir -p ~/.config/feroxbuster
	cp ~/dotfiles/feroxbuster/ferox-config.toml

	# Set up git update crontab
	mkdir ~/.git_update
	cp ~/dotfiles/git_update.sh ~/.git_update/git_update.sh
	chmod +x ~/.git_update/git_update.sh
	printf "\n# Git update script\n0 8 \* \* 7\t$USER\t$HOME/.git_update/git_update.sh\n" | sudo tee -a /etc/crontab
}

git_personal() {
	# Get personal repositories
	git clone git@github.com:xbufu/CySec.git ~/CySec
	git clone git@github.com:xbufu/LearnCodeTheHardWay.git ~/LearnCodeTheHardWay
}

kali_fixes() {
	# Fix rockyou.xt
	sudo gunzip /usr/share/wordlists/rockyou.txt.gz
	
	# Disable terminal beep
	echo "blacklist pcspkr" | sudo tee /etc/modprobe.d/nobeep.conf
	xset b off

	# Set root password
	read -n 1 -p "Set root password (ENTER to continue):"
	sudo passwd root
}

nmap_fix() {
	sudo rm -f /usr/share/nmap/scripts/clamav-exec.nse
	wget https://raw.githubusercontent.com/nmap/nmap/master/scripts/clamav-exec.nse -O clamav-exec.nse
	sudo mv clamav-exec.nse /usr/share/nmap/scripts/clamav-exec.nse
	wget https://raw.githubusercontent.com/onomastus/pentest-tools/master/fixed-http-shellshock.nse -O http-shellshock.nse
	sudo mv http-shellshock.nse /usr/share/nmap/scripts/http-shellshock.nse
}

impacket_fix() {
	# Set up impacket
	wget https://github.com/SecureAuthCorp/impacket/releases/download/impacket_0_9_22/impacket-0.9.22.tar.gz
	tar xvf ~/impacket-0.9.22.tar.gz
	mv impacket-0.9.22 /opt/impacket-0.9.22
	rm -f impacket-0.9.22.tar.gz
	pip2 uninstall impacket
	pip3 uninstall impacket
	chmod -R 755 /opt/impacket-0.9.22
	pip3 install lsassy
	pip install flask
	pip install pyasn1
	pip install pycryptodomex
	pip install pyOpenSSL
	pip install ldap3
	pip install ldapdomaindump
	pip install wheel
	cd /opt/impacket-0.9.22
	pip install .
	pip3 install .
	sudo apt reinstall -y python3-impacket impacket-scripts
	cd ~
}

basic_tools() {
	sudo apt install -y curl wget tmux neovim manpages-dev manpages-posix-dev libssl-dev libffi-dev build-essential openssl gnupg mlocate xclip dkms linux-headers-amd64 gnome-terminal htop wordlists
	
	read -n 1 -p "Set default terminal emulator (ENTER to continue):"
	sudo update-alternatives --config x-terminal-emulator
}

get_bash() {
	sudo apt purge -y zsh
	chsh -s /bin/bash
	read -n 1 -p "Change your shell in /etc/passwd (ENTER to continue):"
	sudo vi /etc/passwd
}

git_setup() {
	sudo apt install -y git
	git config --global pull.rebase true
	read -p "Enter git username: " git_user
	git config --global user.name "$git_user"
	read -p "Enter git email: " git_email
	git config --global user.email "$git_email"
	ssh -T git@github.com
}

recon_tools() {
	# Set up rustscan
	wget https://github.com/RustScan/RustScan/releases/download/2.0.1/rustscan_2.0.1_amd64.deb -O rustscan_2.0.1_amd64.deb
	sudo apt install -y ~/rustscan_2.0.1_amd64.deb
	rm -f rustscan_2.0.1_amd64.deb
	
	# Install gobuster
	sudo apt install -y gobuster
	
	# Set up feroxbuster
	wget https://github.com/epi052/feroxbuster/releases/download/v2.0.0/feroxbuster_amd64.deb.zip -O feroxbuster_amd64.deb.zip
	unzip feroxbuster_amd64.deb.zip
	sudo apt install -y ~/feroxbuster_2.0.0_amd64.deb
	rm -f feroxbuster_2.0.0_amd64.deb feroxbuster_amd64.deb.zip

	# Set up AutoRecon
	sudo apt install -y seclists curl enum4linux gobuster nbtscan nikto nmap onesixtyone oscanner smbclient smbmap smtp-user-enum snmp sslscan sipvicious tnscmd10g whatweb wkhtmltopdf
	pipx install git+https://github.com/Tib3rius/AutoRecon.git

	# Set up enum4linux-ng
	sudo apt install -y smbclient python3-ldap3 python3-yaml python3-impacket
	git clone https://github.com/cddmp/enum4linux-ng.git /opt/enum4linux-ng
	cd /opt/enum4linux-ng
	pip3 install -r requirements.txt
	sudo ln -s /opt/enum4linux-ng/enum4linux-ng.py /usr/bin/enum4linux-ng
	cd ~

	# GitTools
	git clone https://github.com/internetwache/GitTools /opt/GitTools
}

re_be_tools() {
	# Set up pwntools
	pip3 install pwntools
	
	# Set up gdb and gef
	sudo apt install -y gdb
	pip3 install capstone
	pip3 install unicorn
	pip3 install keystone-engine
	pip3 install ropper
	pip2 install capstone
	pip2 install unicorn
	pip2 install keystone-engine
	pip2 install ropper
	git clone https://github.com/hugsy/gef.git /opt/gef
	echo 'source /opt/gef/gef.py' >> ~/.gdbinit
	echo 'set disassembly-flavor intel' >> ~/.gdbinit
	
	# Set up Ghidra
	wget https://ghidra-sre.org/ghidra_9.2.2_PUBLIC_20201229.zip -O ghidra_9.2.2.zip
	unzip ghidra_9.2.2.zip
	mv ghidra_9.2.2_PUBLIC /opt/ghidra
	rm -f ghidra_9.2.2.zip
	sudo ln -s /opt/ghidra/ghidraRun /usr/bin/ghidra
	git clone https://github.com/zackelia/ghidra-dark.git
	cd ghidra-dark
	python3 install.py
	cd ~
	rm -rf ghidra-dark
	
	# Install radare2 and cutter
	sudo apt install -y radare2 radare2-cutter
}

crypto_tools() {
	# Install name-that-hash and stegcracker
	pipx install name-that-hash
	pipx install stegcracker
	sudo apt install -y binwalk exiftool steghide xxd ghex
	git clone https://github.com/Ganapati/RsaCtfTool /opt/RsaCtfTool
	pip3 install -r /opt/RsaCtfTool/requirements.txt
}

privesc_tools() {
	# Linux
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
	pip3 install /opt/wesng

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
}

#########################
#         START         #
#########################

cd ~
usr=$USER
sudo chown -R $usr:$usr /opt

# Perform full update
sudo apt update && sudo apt upgrade -y && sudo apt autoremove -y && sudo apt autoclean -y

# Prerequisites
git_ssh_check
basic_tools

# Configs and repos 
git_setup
config_setup

# Programming languages
python_setup
java_setup
go_setup

# Fixes
kali_fixes
impacket_fix
get_bash

# Tools
recon_tools
re_be_tools
crypto_tools
privesc_tools
