#!/bin/bash

while true; do
  package=$(
    zenity --entry \
           --title="Update Package" \
           --text="Insert package name:" \
           --cancel-label="Back"
  )

  if [ -z "$package" ]; then
    break
  fi

  if ! yay -Q "$package" >/dev/null 2>&1; then
    zenity --error \
           --title="Update Package" \
           --text="Package is not installed." \
           --ok-label="Back"
      
    continue
  fi

  password=$(
    zenity --forms \
           --title="Update Package" \
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
           --title="Update Package" \
           --text="Invalid password." \
           --ok-label="Back"

    continue
  fi

  yay -S --noconfirm "$package" |
    zenity --progress \
           --title="Update Package" \
           --text="Updating package..." \
           --pulsate \
           --auto-close \
           --no-cancel

  zenity --info \
          --title="Update Package" \
          --text="Package updated!"

  break
done