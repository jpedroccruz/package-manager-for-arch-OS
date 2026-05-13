#!/bin/bash

yay -Qq | zenity --text-info \
                 --title="List Installed Packages" \
                 --width=600 \
                 --height=450 \
                 --cancel-label="Back"
