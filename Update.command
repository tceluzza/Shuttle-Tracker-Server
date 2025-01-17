#!/bin/bash

source ~/.bashrc
if [ $(id -u) -ne 0 ]; then
	echo "ERROR: This script must be run as root." >> /dev/stderr
	exit
fi
echo "Stopping daemon..." >> /dev/stdout
supervisorctl stop shuttle >> /var/log/shuttle_update.log
echo "Downloading shuttle tracker server..." >> /dev/stdout
cd "$root"
git pull >> /var/log/shuttle_update.log
echo "Building shuttle tracker server (this may take a while)..." >> /dev/stdout
swift build -c release >> /var/log/shuttle_update.log
echo "Starting daemon..." >> /dev/stdout
supervisorctl start shuttle >> /var/log/shuttle_update.log
echo "The shuttle tracker server has been updated! You can check out the update log in \`/var/log/shuttle_update.log\`." >> /dev/stdout
