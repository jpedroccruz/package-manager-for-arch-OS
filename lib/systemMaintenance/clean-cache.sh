#!/bin/bash

while true; do
  password=$(
    zenity --forms \
           --title="Clean Cache" \
           --text="Insert your sudo password" \
           --add-password="Password" \
           --cancel-label="Back"
  )

  if [ $? -eq 1 ]; then
    break
  fi

  sudo -k
  echo "$password" | sudo -S true 2>/dev/null
  AUTH=$?

  if [ $AUTH -ne 0 ]; then
    zenity --error \
           --title="Clean Cache" \
           --text="Invalid password." \
           --ok-label="Back"

    continue
  fi

  echo "$password" | sudo -S paccache -r |
    zenity --progress \
           --title="Clean Cache" \
           --text="Cleaning..." \
           --pulsate \
           --auto-close \
           --no-cancel

  zenity --info \
         --title="Clean Cache" \
         --text="Cache Cleaned!"
  break
done