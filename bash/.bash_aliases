alias full-update='apt update && apt upgrade -y && apt autoremove -y && apt autoclean -y'
alias vi='nvim'
alias up='python3 -m http.server 80'
alias pyenv2='virtualenv -p /usr/bin/python2 venv && source venv/bin/activate'
alias pyenv3='virtualenv -p /usr/bin/python3 venv && source venv/bin/activate'
alias htb-vpn='openvpn --cd $HOME/.openvpn --config htb.ovpn'
alias thm-vpn='openvpn --cd $HOME/.openvpn --config thm.ovpn'
alias pg-vpn='openvpn --cd $HOME/.openvpn --config pg.ovpn'
alias ssh2john='/usr/share/john/ssh2john.py'
alias dirsearch='/opt/dirsearch/dirsearch.py'
alias alph='echo "AAAABBBBCCCCDDDDEEEEFFFFGGGGHHHHIIIIJJJJKKKKLLLLMMMMNNNNOOOOPPPPQQQQRRRRSSSSTTTTUUUUVVVVWWWWXXXXYYYYZZZZ"'
alias gdb='gdb -q'
alias nmap-initial='nmap -sCV -Pn -v -T4 -o nmap_initial.txt'
alias nmap-all='nmap -sCV -p- -Pn -v -T4 -o nmap_all.txt'
