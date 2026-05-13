#!/bin/bash

ifconfig | zenity --text-info \
                  --title="Network Config" \
                  --width=700 \
                  --height=400