#!/bin/bash

while true; do
  package=$(
    zenity --entry \
           --title="Show Package Info" \
           --text="Insert package name:" \
           --cancel-label="Back"
  )

  if [ -z "$package" ]; then
    break
  fi

  if ! yay -Si "$package" >/dev/null 2>&1; then
    zenity --error \
           --title="Show Package Info" \
           --text="Package does not exist." \
           --ok-label="Back"
      
    continue
  fi

  yay -Si "$package" |
     zenity --text-info \
            --title="Show Package Info" \
            --width=600 \
            --height=450 \
            --cancel-label="Back"

  break
done