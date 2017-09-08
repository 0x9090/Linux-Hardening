#!/bin/bash

if [ "$EUID" -ne 0 ]; then
	echo "Please run as root"
	exit
fi

current_path=${PWD##*/}

apt update && apt upgrade -y
apt install puppet -y

