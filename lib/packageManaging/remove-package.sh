#!/bin/bash

while true; do
  package=$(
    zenity --entry \
           --title="Remove Package" \
           --text="Insert package name:" \
           --cancel-label="Back"
  )

  if [ -z "$package" ]; then
    break
  fi

  if ! yay -Q "$package" >/dev/null 2>&1; then
    zenity --error \
           --title="Remove Package" \
           --text="Package does not exist." \
           --ok-label="Back"
      
    continue
  fi

  password=$(
    zenity --forms \
           --title="Remove Package" \
           --text="Insert your sudo password" \
           --add-password="Password" \
           --cancel-label="Back"
  )

  if [ $? -eq 1 ]; then
    break
  fi
  
  sudo -k
  echo "$password" | sudo -Sv 2>/dev/null
  AUTH=$?

  if [ $AUTH -ne 0 ]; then
    zenity --error \
           --title="Remove Package" \
           --text="Invalid password." \
           --ok-label="Back"

    continue
  fi

  yay -R --noconfirm "$package" |
    zenity --progress \
           --title="Remove Package" \
           --text="Removing..." \
           --pulsate \
           --auto-close \
           --no-cancel

  zenity --info \
         --title="Remove Package" \
         --text="Package removed!"

  break
done