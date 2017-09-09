#!/bin/bash

if [ "$EUID" -ne 0 ]; then
	echo "Please run as root"
	exit
fi

current_path=${PWD##*/}

wget https://apt.puppetlabs.com/puppet-release-stretch.deb
dpkg -i puppet-release-stretch.deb
rm puppet-release-stretch.deb
apt update && apt upgrade -y
apt install puppet -y
