#!/bin/bash

if [[ -z "$1" ]]
then
    echo "Usage: $0 <file>"
    exit
fi

cat $1 | sed -r 's/!\[\[Pasted image (.*)png\]\]/!\[\]\(https:\/\/github.com\/xbufu\/OSCP-Journey\/blob\/master\/attachments\/Pasted%20image%20\1png?raw=true\)/g'

