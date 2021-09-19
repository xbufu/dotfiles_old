#!/bin/bash

if [ -d /proc/sys/net/ipv4/conf/tun0 ]
then
        echo "tun0 $({ ip -4 -br a sh dev tun0 | awk {'print $3'} | cut -f1 -d/; } 2>/dev/null)"
elif [ -d /proc/sys/net/ipv4/conf/tap0 ]
then
        echo "tap0 $({ ip -4 -br a sh dev tap0 | awk {'print $3'} | cut -f1 -d/; } 2>/dev/null)"
elif [ -d /proc/sys/net/ipv4/conf/ppp0 ]
then
        echo "ppp0 $({ ip -4 -br a sh dev ppp0 | awk {'print $3'} | cut -f1 -d/; } 2>/dev/null)"
elif [ -d /proc/sys/net/ipv4/conf/eth0 ]
then
        echo "eth0 $({ ip -4 -br a sh dev eth0 | awk {'print $3'} | cut -f1 -d/; } 2>/dev/null)"
fi
