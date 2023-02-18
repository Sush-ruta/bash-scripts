#!/bin/bash

if ! command -v iwgetid &> /dev/null
then
    echo "iwgetid is not installed. Please install it and try again."
    exit
fi

if ! command -v qrencode &> /dev/null; then
    echo "qrencode is not installed. Please install it and try again." >&2
    exit 1
fi

# check if we have root privileges
if [[ $(id -u) -ne 0 ]]; then
    echo "This script requires root privileges. Please run with 'sudo'." >&2
    exit 1
fi

# get the SSID of the connected network
ssid=$(iwgetid -r)

if [[ -z $ssid ]]; then
    echo "You are not connected to a Wi-Fi network." >&2
    exit 1
fi

# find the corresponding configuration file for the network
config_file=$(find /etc/NetworkManager/system-connections/ -type f -name "$ssid.nmconnection")

if [[ -z $config_file ]]; then
    echo "Could not find the configuration file for this network." >&2
    exit 1
fi

# extract the password from the configuration file
password=$(sudo grep -Po '^psk=\K.*' "$config_file")

if [[ -z $password ]]; then
    echo "Could not find the password for this network." >&2
    exit 1
fi

# generate a QR code from the SSID and password
qrencode -t ANSIUTF8 "WIFI:T:WPA;S:$ssid;P:$password;;"

# print the password for the user
echo "The password for the Wi-Fi network '$ssid' is: $password"
