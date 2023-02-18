#!/bin/bash

# Get the text input from the first argument
TEXT=$1

# If no input is provided, use a default message
if [ -z "$TEXT" ]; then
  TEXT="Sample notification!"
fi

# Get the current time in HH:MM format
TIME=$(date +%H:%M)

# Append the time to the text message
TEXT="$TEXT ($TIME)"

# Send a notification using notify-send command[^1^][1]
notify-send "$TEXT"
