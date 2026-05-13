#!/bin/bash

while true; do
  password=$(
    zenity --forms \
           --title="Remove Unused Packages" \
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
           --title="Remove Unused Packages" \
           --text="Invalid password." \
           --ok-label="Back"

    continue
  fi

  orphans=$(pacman -Qtdq)

  if [ -z "$orphans" ]; then
    zenity --info \
           --title="Remove Unused Packages" \
           --text="There are no unused packages to remove."
    break
  fi

  echo "$password" | sudo -S pacman -Rns --noconfirm $orphans | 
    zenity --progress \
           --title="Remove Unused Packages" \
           --text="Removing packages..." \
           --pulsate \
           --auto-close

  zenity --info \
         --title="Remove Unused Packages" \
         --text="Unused packages removed!"
  break
done