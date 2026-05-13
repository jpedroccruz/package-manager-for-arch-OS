#!/bin/bash

while true; do
	chose=$(zenity --list \
								 --text="" \
								 --title="SysManager" \
								 --hide-header \
								 --column="Options" "Package Managing" "System Maintenance" "Network" \
								 --cancel-label="Exit" \
								 --extra-button="About" \
								 --width=150
	)

	if [ -z "$chose" ]; then
		zenity --question \
					 --title="SysManager" \
					 --text="Are you sure you want to exit?" \
					 --ok-label="Yes" \
					 --cancel-label="No" \
					 --width=300

		[ $? -eq 0 ] && exit
		
		continue
	fi

	case $chose in 
			"Package Managing")
				lib/packageManaging-menu.sh
				;;
			"System Maintenance")
				lib/systemMaintenance-menu.sh
				;;
			"Network")
				lib/network-menu.sh
				;;
			"About")
				lib/about.sh
				;;
	esac
done