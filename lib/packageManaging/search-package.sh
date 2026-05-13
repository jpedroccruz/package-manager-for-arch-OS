#!/bin/bash

while true; do
  package=$(
    zenity --entry \
           --title="Search Package" \
           --text="Insert package name:" \
           --cancel-label="Back"
  )

  if [ -z "$package" ]; then
    break
  fi

  if ! yay -Si "$package" >/dev/null 2>&1; then
    zenity --error \
           --title="Search Package" \
           --text="Package does not exist." \
           --ok-label="Back"
      
    continue
  fi

  zenity --info \
          --title="Search Package" \
          --text="Package found!"

  break
done