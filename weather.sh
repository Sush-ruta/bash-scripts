#!/bin/bash

# To make a cron job that will run this script once every hour, follow these steps:
# 1. Save this script as a file, for example weather.sh, and make it executable with chmod +x weather.sh
# 2. Open your crontab file with crontab -e command
# 3. Add this line at the end of your crontab file: 0 * * * * /path/to/weather.sh
# 4. Save and exit your crontab file

# Get the public IP address of the system
ip=$(curl -s ifconfig.me)

# Get the location data from ipinfo.io API
location=$(curl -s https://ipinfo.io/$ip)

# Extract the city and country from the location data
city=$(echo $location | jq -r '.city')
country=$(echo $location | jq -r '.country')

# Get the weather information from wttr.in
weather=$(curl -s wttr.in/$city?format=1)

# Extract the temperature in Celsius from the weather information
temp=$(echo $weather | cut -d' ' -f2 | tr -d '+')

# Send a notification with the temperature and location
notify-send "The temperature in $city, $country is $temp"
