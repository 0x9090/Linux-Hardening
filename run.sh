#!/bin/bash

if [ "$EUID" -ne 0 ]; then
	echo "Please run as root"
	exit
fi

puppet apply --verbose --config=./puppet.conf --modulepath=./modules site.pp