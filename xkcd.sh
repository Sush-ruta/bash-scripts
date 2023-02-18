#!/bin/bash

usage() {
    echo "Usage: $0 [-n <number>]"
    echo "  -n <number> : Download the xkcd comic with the specified number"
    echo "                If not specified, the latest comic will be downloaded."
    exit 1
}

latest=$(curl -s 'https://xkcd.com/info.0.json' | jq -r '.num')
number=$latest

while getopts ":n:h" opt; do
    case $opt in
        n)
            if ! [[ $OPTARG =~ ^[0-9]+$ ]]; then
                echo "Error: Number must be an integer."
                exit 1
            fi
            if (( $OPTARG < 1 || $OPTARG > $latest )); then
                echo "Error: Number must be between 1 and $latest."
                exit 1
            fi
            number=$OPTARG
            ;;
        h)
            usage
            ;;
        \?)
            echo "Error: Invalid option -$OPTARG"
            usage
            ;;
    esac
done

url="https://xkcd.com/${number}/info.0.json"
response=$(curl -s "$url")
img_url=$(echo "$response" | jq -r '.img')
title=$(echo "$response" | jq -r '.safe_title')
filename="$number - $title.png"
echo "Downloading xkcd comic $number: $title"
curl -s "$img_url" > "$HOME/Pictures/xkcd/$filename"
echo "Comic saved as $filename"
