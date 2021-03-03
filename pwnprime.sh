#!/bin/bash

function kali_fixes() {
    # Pimp My Kali
    git clone https://github.com/Dewalt-arch/pimpmykali.git /opt/pimpmykali
    sudo /opt/pimpmykali/pimpmykali.sh
    
    # Disable login message
    touch ~/.hushlogin
}

function git_setup() {
    sudo apt install -y git
    git config --global pull.rebase true
    read -p "Enter git username: " git_user
    git config --global user.name "$git_user"
    read -p "Enter git email: " git_email
    git config --global user.email "$git_email"
    git config --global init.defaultBranch main
    ssh -T git@github.com
}

function pipx_setup() {
    sudo apt install -y python3-venv
    python3 -m pip install --user pipx
    python3 -m pipx ensurepath
    read -n 1 -p "Append $HOME/.local/bin to secure_path (ENTER to continue):"
    sudo visudo
}

function java_setup() {
    sudo apt install -y openjdk-11-jdk openjdk-11-jre openjdk-11-dbg openjdk-11-doc
    echo -e "\n# Java\nexport JAVA_HOME=/usr/lib/jvm/java-11-openjdk-amd64" >> ~/.bashrc
    echo -e "export PATH=\$PATH:\$JAVA_HOME/bin" >> ~/.bashrc
}

function enum_tools() {
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

    # CrackMapExec
    pipx install crackmapexec
}

function pwn_tools() {
    python3 -m pip install pwntools

    # Set up gdb and gef
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

    # Install radare2 and cutter front-end
    sudo apt install -y radare2 radare2-cutter
}

function crypto_tools() {
    pipx install name-that-hash
    pipx install stegcracker
    sudo apt install -y binwalk exiftool steghide xxd ghex
    git clone https://github.com/Ganapati/RsaCtfTool /opt/RsaCtfTool
    python3 -m pip install -r /opt/RsaCtfTool/requirements.txt
}

function privesc_tools() {
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
    mkdir -p ~/privesc/linux
    ln -s /opt/LinEnum/LinEnum.sh ~/privesc/linux/linenum.sh
    ln -s /opt/linux-exploit-suggester-2/linux-exploit-suggester-2.pl ~/privesc/linux/les2.pl
    ln -s /opt/SUID3NUM/suid3num.py ~/privesc/linux/suidenum.py
    ln -s /opt/pspy/pspy32 ~/privesc/linux/pspy32
    ln -s /opt/pspy/pspy32s ~/privesc/linux/pspy32s
    ln -s /opt/pspy/pspy64 ~/privesc/linux/pspy64
    ln -s /opt/pspy/pspy64s ~/privesc/linux/pspy64s
    ln -s /opt/privilege-escalation-awesome-scripts-suite/linPEAS/linpeas.sh ~/privesc/linux/linpeas.sh
    ln -s /opt/privilege-escalation-awesome-scripts-suite/winPEAS/winPEASbat/winPEAS.bat ~/privesc/linux/winpeas.bat
    ln -s /opt/privilege-escalation-awesome-scripts-suite/winPEAS/winPEASexe/winPEAS/bin/x64/Release/winPEAS.exe ~/privesc/linux/winpeas64.exe
    ln -s /opt/privilege-escalation-awesome-scripts-suite/winPEAS/winPEASexe/winPEAS/bin/x86/Release/winPEAS.exe ~/privesc/linux/winpeas32.exe
    ln -s /opt/static-binaries/binaries/linux/x86_64/ncat ~/privesc/linux/nc
    
    git clone https://github.com/saghul/lxd-alpine-builder /opt/lxd-alpine-builder
    cd /opt/lxd-alpine-builder
    mkdir -p /opt/lxd-alpine-builder/rootfs/usr/share/alpine-mirrors
    wget http://dl-cdn.alpinelinux.org/alpine/MIRRORS.txt -O /opt/lxd-alpine-builder/rootfs/usr/share/alpine-mirrors/MIRRORS.txt
    sudo ./build-alpine
    ln -s /opt/lxd-alpine-builder/alpine-v3.13-x86_64-20210228_2142.tar.gz ~/privesc/linux/alpine.tar.gz
    cd ~
}

function config_setup() {
    git clone git@github.com:xbufu/dotfiles.git ~/dotfiles
    ln ~/dotfiles/.bash_aliases ~/.bash_aliases

    # Set up neovim
    sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
    mkdir -p ~/.config/nvim
    ln ~/dotfiles/init.vim ~/.config/nvim/init.vim
    nvim --headless +PlugInstall +qa

    # Set up tmux
    ln ~/dotfiles/.tmux.conf ~/.tmux.conf
    mkdir -p ~/.config/tmux
    ln ~/dotfiles/vpn.sh ~/.config/tmux/vpn.sh

    # Autokey
    wget https://github.com/autokey/autokey/releases/download/v0.95.10/autokey-common_0.95.10-0_all.deb -O ~/autokey-common_0.95.10-0_all.deb
    wget https://github.com/autokey/autokey/releases/download/v0.95.10/autokey-gtk_0.95.10-0_all.deb -O ~/autokey-gtk_0.95.10-0_all.deb
    VERSION="0.95.10-0"
    sudo dpkg --install autokey-common_${VERSION}_all.deb autokey-gtk_${VERSION}_all.deb
    sudo apt -y --fix-broken install

    # Set up git repo update script
    mkdir ~/.git_update
    ln ~/dotfiles/git_update.sh ~/.git_update/git_update.sh
    chmod +x ~/.git_update/git_update.sh
    echo -e "\n# Git update script\n0 8 * * 7\t$USER\t$HOME/.git_update/git_update.sh" | sudo tee -a /etc/crontab

    # Autorecon
    arpath='~/.local/pipx/venvs/autorecon/lib/python3.9/site-packages/autorecon/config'
    rm -f $arpath/port-scan-profiles-default.toml $arpath/service-scans-default.toml
    ln ~/dotfiles/autorecon/port-scan-profiles-default.toml $arpath/port-scan-profiles-default.toml
    ln ~/dotfiles/autorecon/port-scan-profiles-default.toml $arpath/service-scans-default.toml
}

echo "
:::::::::  :::       ::: ::::    ::: :::::::::  :::::::::  ::::::::::: ::::    ::::  :::::::::: 
:+:    :+: :+:       :+: :+:+:   :+: :+:    :+: :+:    :+:     :+:     +:+:+: :+:+:+ :+:        
+:+    +:+ +:+       +:+ :+:+:+  +:+ +:+    +:+ +:+    +:+     +:+     +:+ +:+:+ +:+ +:+        
+#++:++#+  +#+  +:+  +#+ +#+ +:+ +#+ +#++:++#+  +#++:++#:      +#+     +#+  +:+  +#+ +#++:++#   
+#+        +#+ +#+#+ +#+ +#+  +#+#+# +#+        +#+    +#+     +#+     +#+       +#+ +#+        
#+#         #+#+# #+#+#  #+#   #+#+# #+#        #+#    #+#     #+#     #+#       #+# #+#        
###          ###   ###   ###    #### ###        ###    ### ########### ###       ### ########## 
"
echo ""
echo ""
echo "
Welcome to The PWNPrime Setup Script. This script is based off of a fresh installation of Kali Linux 2020.4.
First the machine will create a filesystem for all folders that are used and make new directories for storage of assets that are whilist on an engagement.
It will then run through installation of PimpMyKali to fix dependancy/package issues w/ your current version of Kali Linux.
Afterwards, it will install RustScan, feroxbuster, ffuf, SecLists, enum4linux-ng, tmux (redesigned), CrackMapExec, Joplin, and more...
Enjoy the script and happy hacking! Cheers from the 'coffee guy'!
-- bufu
"

# Path fix for python and go
PATH=$PATH:$HOME/.local/bin:/usr/local/go/bin:$HOME/go/bin

# Kali Linux Update and Upgrade
sudo apt update && sudo apt -y upgrade && sudo apt -y autoremove && sudo apt -y autoclean

# Change owner of opt
user=$USER
sudo chown $user:$user /opt
unset user

# Install basic tools
sudo apt install -y curl wget tmux neovim manpages-dev manpages-posix-dev libssl-dev libffi-dev build-essential openssl gnupg mlocate xclip dkms linux-headers-amd64 htop libmpc-dev

# Set default shell to bash
chsh -s `which bash`

# Note taking software
wget -O - https://raw.githubusercontent.com/laurent22/joplin/dev/Joplin_install_and_update.sh | bash

kali_fixes
git_setup
pipx_setup
java_setup
enum_tools
pwn_tools
crypto_tools
privesc_tools
config_setup

sudo apt update && sudo apt -y upgrade && sudo apt -y autoremove && sudo apt -y autoclean

echo -e "To enable dark mode theme for ghidra run it once and close it. Then run the following command:\n"
echo -e "\t python3 /opt/ghidra-dark/install.py --path /opt/ghidra"
