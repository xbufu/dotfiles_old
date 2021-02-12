#!/bin/bash

cd /opt
find . -type d -maxdepth 1 -exec git --git-dir={}/.git --work-tree=$PWD/{} pull \; | tee -a ~/.git_update/log.txt
cd /opt/ffuf
go get
go build
