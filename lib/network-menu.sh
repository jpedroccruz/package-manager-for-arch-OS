#!/bin/bash

while true; do
	chose=$(zenity --list \
								 --text="" \
							 	 --title="Network" \
								 --hide-header \
								 --column="Options" "Show Network Config" "Test Network Access" "Test DNS Service" \
								 --cancel-label="Back"
	)

	if [ $? -eq 1 ]; then
		break
	fi 

	case $chose in
		"Show Network Config")
			lib/network/show-network-config.sh
			;;
		"Test Network Access")
			lib/network/test-network-access.sh
			;;
		"Test DNS Service")
			lib/network/test-dns-service.sh
			;;
	esac
done