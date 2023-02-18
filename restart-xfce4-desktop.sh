#!/bin/bash
# This script will kill and restart the xfce4-panel and xfwm4 processes

# Kill the xfce4-panel process
killall xfce4-panel

# Restart the xfce4-panel process
xfce4-panel & disown

# Replace the xfwm4 process
xfwm4 --replace & disown
