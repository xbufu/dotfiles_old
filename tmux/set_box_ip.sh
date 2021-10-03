#!/bin/bash

if [ ! -z "$1" ]
then
    if [ "$1" = "clear" ]
    then
        echo "" > ~/.config/tmux/box_ip.txt
    else
        echo "box $1" > ~/.config/tmux/box_ip.txt
    fi
else
    echo "Usage: $0 <IP>"
    exit
fi
