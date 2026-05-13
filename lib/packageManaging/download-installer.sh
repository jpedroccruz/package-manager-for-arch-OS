#!/bin/bash

while true; do
  package=$(
    zenity --entry \
           --title="Download Installer" \
           --text="Insert package name:" \
           --cancel-label="Back"
  )

  if [ -z "$package" ]; then
    break
  fi

  if ! yay -Si "$package" >/dev/null 2>&1; then
    zenity --error \
           --title="Download Installer" \
           --text="Package does not exist." \
           --ok-label="Back"
      
    continue
  fi

  password=$(
    zenity --forms \
           --title="Download Installer" \
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
           --title="Download Installer" \
           --text="Invalid password." \
           --ok-label="Back"

    continue
  fi

  yay -Sw --noconfirm "$package" |
    zenity --progress \
           --title="Download Installer" \
           --text="Installing..." \
           --pulsate \
           --auto-close \
           --no-cancel

  zenity --info \
          --title="Download Installer" \
          --text="Installer downloaded!"

  break
done