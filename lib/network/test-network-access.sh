#!/bin/bash

if ping -c 1 8.8.8.8 >/dev/null 2>&1; then
	zenity --info \
				 --title="Test Network Access" \
				 --text="Network access is working."
else
	zenity --error \
				 --title="Test Network Access" \
				 --text="Unable to reach the network."
fi
