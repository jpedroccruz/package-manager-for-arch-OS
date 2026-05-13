#!/bin/bash

if getent hosts google.com >/dev/null 2>&1; then
	zenity --info \
				 --title="DNS Service" \
				 --text="DNS resolution is working."
else
	zenity --error \
				 --title="DNS Service" \
				 --text="DNS resolution is not working."
fi