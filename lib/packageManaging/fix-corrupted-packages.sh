#!/bin/bash

while true; do
  pacman -Dk >/dev/null 2>&1
  corrupted=$?

  if [ $corrupted -eq 0 ]; then
    zenity --info \
           --title="Fix Corrupted Packages" \
           --text="No corrupted packages found."
    break
  fi

  pacman -Dk | 
    zenity --text-info \
           --title="Fix Corrupted Packages" \
           --width=600 \
           --height=450 \
           --cancel-label="Back"
           
  if [ $? -eq 1 ]; then
    break
  fi

  package=$(
    zenity --entry \
           --title="Fix Corrupted Packages" \
           --text="Insert package name:" \
           --cancel-label="Back" \
           --width=400 \
           --height=150
  )

  if [ -z "$package" ]; then
    break
  fi

  if ! pacman -Q "$package" >/dev/null 2>&1; then
    zenity --error \
           --title="Fix Corrupted Packages" \
           --text="Package does not exist." \
           --ok-label="Back"
      
    continue
  fi

  password=$(
    zenity --forms \
           --title="Fix Corrupted Packages" \
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
           --title="Fix Corrupted Packages" \
           --text="Invalid password." \
           --ok-label="Back"

    continue
  fi

  echo "$password" | sudo -S pacman -S --overwrite "*" "$package" --noconfirm |
    zenity --progress \
           --title="Fix Corrupted Packages" \
           --text="Fixing packages..." \
           --pulsate \
           --auto-close

  zenity --info \
         --title="Fix Corrupted Packages" \
         --text="Packages fixed!"
  break
done