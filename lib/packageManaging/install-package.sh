#!/bin/bash

while true; do
  package=$(
    zenity --entry \
           --title="Install Package" \
           --text="Insert package name:" \
           --cancel-label="Back" \
           --width=400 \
           --height=150
  )

  if [ -z "$package" ]; then
    break
  fi

  if ! yay -Si "$package" >/dev/null 2>&1; then
    zenity --error \
           --title="Install Package" \
           --text="Package does not exist." \
           --ok-label="Back"
      
    continue
  fi

  password=$(
    zenity --forms \
           --title="Install Package" \
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
           --title="Install Package" \
           --text="Invalid password." \
           --ok-label="Back"

    continue
  fi

  yay -S --noconfirm "$package" |
    zenity --progress \
           --title="Install Package" \
           --text="Installing..." \
           --pulsate \
           --auto-close \
           --no-cancel

  zenity --info \
          --title="Install Package" \
          --text="Package installed!"

  break
done