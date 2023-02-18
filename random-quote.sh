#!/usr/bin/env bash

# Check if 'jq' is installed
if ! command -v jq &> /dev/null; then
    echo "Error: 'jq' is not installed. Please install 'jq' and try again."
    exit 1
fi

# Fetch a random quote from the Quotable API
response=$(curl -s https://api.quotable.io/random)

# Extract the quote and author from the response
quote=$(echo "$response" | jq -r '.content')
author=$(echo "$response" | jq -r '.author')

# Create the notification message
message="$quote - $author"

# Display the notification
notify-send "Random Quote" "$message"

# Save quote to past-quotes file
#echo "$(date +'%Y-%m-%d %H:%M:%S') - $quote - $author" >> ~/.past-quotes.txt
