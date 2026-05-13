#!/bin/bash

while true; do
	chose=$(zenity --list \
								 --text="" \
								 --title="Package Managing" \
								 --hide-header \
								 --column="Options" "Install Package" "Remove Package" "Search Package" "Update Packages List" "Update Package" "Show Package Info" "List Installed Packages" "Download Installer" "Fix Corrupted Packages" \
								 --cancel-label="Back" \
								 --height=550
	)

	if [ $? -eq 1 ]; then
		break
	fi 

	case $chose in
		"Install Package")
			lib/packageManaging/install-package.sh
			;;
		"Remove Package")
			lib/packageManaging/remove-package.sh
			;;
		"Search Package")
			lib/packageManaging/search-package.sh
			;;
		"Update Packages List")
			lib/packageManaging/update-packages-list.sh
			;;
		"Update Package")
			lib/packageManaging/update-package.sh
			;;
		"Show Package Info")
			lib/packageManaging/show-package-info.sh
			;;
		"List Installed Packages")
			lib/packageManaging/list-installed-packages.sh
			;;
		"Download Installer")
			lib/packageManaging/download-installer.sh
			;;
		"Fix Corrupted Packages")
			lib/packageManaging/fix-corrupted-packages.sh
			;;
	esac	
done