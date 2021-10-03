#!/bin/bash

BOX=""
HOST=""

if [ -f ~/.config/tmux/box_ip.txt ]
then
    BOX="$(cat ~/.config/tmux/box_ip.txt)"
fi

if [ -d /proc/sys/net/ipv4/conf/tun0 ]
then
        HOST="tun0 $({ ip -4 -br a sh dev tun0 | awk {'print $3'} | cut -f1 -d/; } 2>/dev/null)"
elif [ -d /proc/sys/net/ipv4/conf/tap0 ]
then
        HOST="tap0 $({ ip -4 -br a sh dev tap0 | awk {'print $3'} | cut -f1 -d/; } 2>/dev/null)"
elif [ -d /proc/sys/net/ipv4/conf/ppp0 ]
then
        HOST="ppp0 $({ ip -4 -br a sh dev ppp0 | awk {'print $3'} | cut -f1 -d/; } 2>/dev/null)"
elif [ -d /proc/sys/net/ipv4/conf/eth0 ]
then
        HOST="eth0 $({ ip -4 -br a sh dev eth0 | awk {'print $3'} | cut -f1 -d/; } 2>/dev/null)"
fi

if [ ! -z "$BOX" ]
then
    echo "$BOX | $HOST"
else
    echo "$HOST"
fi
