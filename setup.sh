#!/bin/bash

if [ "$EUID" -ne 0 ]; then
	echo "Please run as root"
	exit
fi

apt update && apt upgrade -y
apt install sudo puppet unzip -y

mkdir /opt/puppet
cd /opt/puppet/
#wget https://github.com/puppetlabs/puppetlabs-stdlib/archive/4.17.1.zip