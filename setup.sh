#!/bin/bash

if [ "$EUID" -ne 0 ]; then
	echo "Please run as root"
	exit
fi

current_path=${PWD##*/}

if [[ $* == *-a* ]]; then
    echo "Automated Install Mode..."
else
    echo "~~~ Ensure you have console access to this machine! ~~~"
    echo "This setup process will flush firewall rules, and you don't want to lose access in an error scenario"
    read -r -p "Continue? [Y/n]: " response
     response=${response,,}
     if [[ $response =~ ^(yes|y| ) ]] || [[ -z $response ]]; then
        echo "Yessir!"
     else
        exit "Exiting"
     fi
fi

wget https://apt.puppetlabs.com/puppet-release-stretch.deb
dpkg -i puppet-release-stretch.deb
rm puppet-release-stretch.deb
apt update && apt upgrade -y
apt install puppet -y

iptables -F
chmod +x ./run.sh
./run.sh
