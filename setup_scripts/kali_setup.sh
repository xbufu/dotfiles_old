#!/bin/bash

function git_setup() {
    apt install -y git
    git config --global pull.rebase true
    read -p "Enter git username: " git_user
    git config --global user.name "$git_user"
    read -p "Enter git email: " git_email
    git config --global user.email "$git_email"
    git config --global init.defaultBranch main
    ssh -T git@github.com
}

function pipx_setup() {
    apt install -y python3-venv
    python3 -m pip install --user pipx
    python3 -m pipx ensurepath --force
    echo -e "\n# Python\nexport PATH=\$PATH:\$HOME.local/bin"
}

function java_setup() {
    apt install -y openjdk-11-jdk openjdk-11-jre openjdk-11-dbg openjdk-11-doc
    echo -e "\n# Java\nexport JAVA_HOME=/usr/lib/jvm/java-11-openjdk-amd64" >> ~/.bashrc
    echo -e "export PATH=\$PATH:\$JAVA_HOME/bin" >> ~/.bashrc
}

function enum_tools() {    
    # Set up feroxbuster
    apt install -y feroxbuster

    pipx install threader3000

    # Set up AutoRecon
    apt install -y seclists curl enum4linux gobuster nbtscan nikto nmap onesixtyone oscanner smbclient smbmap smtp-user-enum snmp sslscan sipvicious tnscmd10g whatweb wkhtmltopdf
    pipx install git+https://github.com/Tib3rius/AutoRecon.git
    autorecon -h >/dev/null
    
    # Set up enum4linux-ng
    apt install -y smbclient python3-ldap3 python3-yaml python3-impacket
    git clone https://github.com/cddmp/enum4linux-ng.git /opt/enum4linux-ng
    cd /opt/enum4linux-ng
    python3 -m pip install -r requirements.txt
    ln -s /opt/enum4linux-ng/enum4linux-ng.py /usr/bin/enum4linux-ng
    cd ~

    # ffuf
    go get -u https://github.com/ffuf/ffuf
}

function pwn_tools() {
    python3 -m pip install pwntools

    # Set up gdb and gef
    apt install -y gdb
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
    ln -s /opt/ghidra/ghidraRun /usr/bin/ghidra
    git clone https://github.com/zackelia/ghidra-dark /opt/ghidra-dark

    # Install radare2 and cutter front-end
    apt install -y radare2 radare2-cutter
}

function crypto_tools() {
    pipx install name-that-hash
    pipx install search-that-hash
    pipx install stegcracker
    apt install -y binwalk exiftool steghide xxd ghex
    git clone https://github.com/Ganapati/RsaCtfTool /opt/RsaCtfTool
    python3 -m pip install -r /opt/RsaCtfTool/requirements.txt
}

function privesc_tools() {
    # Linux
    git clone https://github.com/andrew-d/static-binaries.git /opt/static-binaries
    git clone https://github.com/rebootuser/LinEnum.git /opt/LinEnum
    git clone https://github.com/mzet-/linux-exploit-suggester /opt/linux-exploit-suggester
    git clone https://github.com/Anon-Exploiter/SUID3NUM /opt/SUID3NUM
    git clone https://github.com/carlospolop/privilege-escalation-awesome-scripts-suite /opt/privilege-escalation-awesome-scripts-suite
    git clone https://github.com/saghul/lxd-alpine-builder /opt/lxd-alpine-builder
    git clone https://github.com/WhiteWinterWolf/wwwolf-php-webshell /opt/wwwolf-php-webshell
    git clone https://github.com/ivan-sincek/php-reverse-shell /opt/php-reverse-shell
    git clone https://github.com/AlmCo/Shellshocker /opt/shellshocker
    pipx install git+https://github.com/ihebski/DefaultCreds-cheat-sheet.git
    git clone https://github.com/cwinfosec/revshellgen /opt/revshellgen
    chmod +x /opt/revshellgen/revshellgen.py
    ln -s /opt/revshellgen/revshellgen.py /usr/bin/rsg
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
    git clone https://github.com/3ndG4me/AutoBlue-MS17-010 /opt/AutoBlue-MS17-010
    git clone https://github.com/helviojunior/MS17-010 /opt/MS17-010
    git clone https://github.com/worawit/MS17-010 /opt/MS17-010-OG
    git clone https://github.com/andyacer/ms08_067 /opt/ms08_067
    git clone https://github.com/ivan-sincek/powershell-reverse-tcp /opt/powershell-reverse-tcp
    git clone https://github.com/turbo/zero2hero /opt/zero2hero-uac-bypass
    python3 -m pip install /opt/wesng
    
}

function config_setup() {
    if [ ! -d ~/dotfiles ];
    then
        git clone git@github.com:xbufu/dotfiles.git ~/dotfiles
    fi

    ln -s ~/dotfiles/bash/.bash_aliases ~/.bash_aliases

    # Set up neovim
    sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
    mkdir -p ~/.config/nvim
    ln -s ~/dotfiles/nvim/init.vim ~/.config/nvim/init.vim
    nvim --headless +PlugInstall +qa

    # Set up tmux
    ln -s ~/dotfiles/tmux/.tmux.conf ~/.tmux.conf
    mkdir -p ~/.config/tmux
    ln -s ~/dotfiles/tmux/vpn.sh ~/.config/tmux/vpn.sh
    echo -e "\nsource /$USER/.bashrc" >> ~/.profile
    echo -e "\nsource /$USER/.bashrc" >> ~/.bash_profile

    # Set up git repo update script
    echo -e "\n# Git update script\n0 8 * * 7\t$USER\t$HOME/dotfiles/git_update.sh" | tee -a /etc/crontab

    # Feroxbuster
    mkdir -p ~/.config/feroxbuster
    ln -s ~/dotfiles/feroxbuster/ferox-config.toml ~/.config/feroxbuster/ferox-config.toml

    # AutoRecon
    if [ ! -d ~/.config/AutoRecon ]
    then
	mkdir ~/.config/AutoRecon
    fi
    rm ~/.config/AutoRecon/port-scan-profiles.toml ~/.config/AutoRecon/service-scans.toml
    ln -s ~/dotfiles/AutoRecon/port-scan-profiles.toml ~/.config/AutoRecon/port-scan-profiles.toml
    ln -s ~/dotfiles/AutoRecon/service-scans.toml ~/.config/AutoRecon/service-scans.toml
}

if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root" 
   exit 1
fi

# Path fix for python and go
PATH=$PATH:$HOME/.local/bin:/usr/local/go/bin:$HOME/go/bin

# Kali Linux Update and Upgrade
apt update && apt -y upgrade && apt -y autoremove && apt -y autoclean

# Install basic tools
apt install -y curl wget tmux neovim manpages-dev manpages-posix-dev libssl-dev libffi-dev build-essential openssl gnupg mlocate xclip dkms linux-headers-amd64 htop libmpc-dev python3-dev python2-dev gimp gcc-multilib

apt install -y powershell-empire starkiller bloodhound


# Set default shell to bash
chsh -s `which bash`

echo -e "\n# Python\nexport PATH=\$PATH:\$HOME/.local/bin" >> ~/.bashrc 

# Functions
git_setup
pipx_setup
java_setup
enum_tools
pwn_tools
crypto_tools
privesc_tools
config_setup

apt update && apt -y upgrade && apt -y autoremove && apt -y autoclean

echo -e "To enable dark mode theme for ghidra run it once and close it. Then run the following command:\n"
echo -e "\t python3 /opt/ghidra-dark/install.py --path /opt/ghidra"
