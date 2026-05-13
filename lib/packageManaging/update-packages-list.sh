#!/bin/bash

while true; do
  password=$(
    zenity --forms \
           --title="Update Packages List" \
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
           --title="Update Packages List" \
           --text="Invalid password." \
           --ok-label="Back"

    continue
  fi

  yay -Sy |
    zenity --progress \
           --title="Update Packages List" \
           --text="Updating list..." \
           --pulsate \
           --auto-close \
           --no-cancel

  zenity --info \
          --title="Update Packages List" \
          --text="Packages List Updated!"

  break
done