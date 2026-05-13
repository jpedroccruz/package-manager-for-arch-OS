#!/bin/bash

while true; do
	chose=$(
		zenity --list \
					 --text="" \
					 --title="System Maintenance" \
					 --hide-header \
					 --column="Options" "Clean Cache" "Remove Unused Packages" \
					 --cancel-label="Back"
	)

	if [ $? -eq 1 ]; then
		break
	fi

	case $chose in
		"Clean Cache")
			lib/systemMaintenance/clean-cache.sh
			;;
		"Remove Unused Packages")
			lib/systemMaintenance/remove-unused-packages.sh
			;;
	esac
done