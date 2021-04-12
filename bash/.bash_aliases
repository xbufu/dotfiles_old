if [[ $EUID -eq 0 ]]
then
    alias full-update='apt update && apt upgrade -y && apt autoremove -y && apt autoclean -y'
    alias up='python3 -m http.server 80'
    alias htb-vpn='openvpn --cd $HOME/.openvpn --config htb.ovpn'
    alias thm-vpn='openvpn --cd $HOME/.openvpn --config thm.ovpn'
    alias pg-vpn='openvpn --cd $HOME/.openvpn --config pg.ovpn'
    alias code='code --user-data-dir /root/.vscode'
else
    alias full-update='sudo apt update && sudo apt -y upgrade && sudo apt -y autoremove && sudo apt -y autoclean'
    alias uni-vpn='sudo openvpn --cd $HOME/.openvpn --config pers-ext.ovpn'
fi

alias vi='nvim'
alias pyenv2='virtualenv -p /usr/bin/python2 venv && source venv/bin/activate'
alias pyenv3='virtualenv -p /usr/bin/python3 venv && source venv/bin/activate'
alias ssh2john='/usr/share/john/ssh2john.py'
alias dirsearch='/opt/dirsearch/dirsearch.py'
alias alph='echo "AAAABBBBCCCCDDDDEEEEFFFFGGGGHHHHIIIIJJJJKKKKLLLLMMMMNNNNOOOOPPPPQQQQRRRRSSSSTTTTUUUUVVVVWWWWXXXXYYYYZZZZ"'
alias gdb='gdb -q'
alias nmap-initial='nmap -A -Pn -v -T4 -o nmap_initial.txt'
alias nmap-all='nmap -A -p- -Pn -v -T4 -o nmap_all.txt'


