#!/bin/bash

if [ "$EUID" -ne 0 ]; then
	echo "Please run as root"
	exit
fi

current_path=${PWD##*/}

apt update && apt upgrade -y
apt install sudo puppet unzip -y

mkdir /opt/puppet /opt/puppet/modules /opt/puppet/manifests
cd /opt/puppet/modules
wget https://github.com/puppetlabs/puppetlabs-stdlib/archive/4.17.1.zip && unzip 4.17.1.zip
#wget https://