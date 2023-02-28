#!/bin/bash

# Help function
function usage {
    echo "Usage: $0 [-h] <date>"
    echo "  -h      Show this help message"
    echo "  date    Date in the format YYYY-MM-DD"
    exit 1
}

# Parse command line options
while getopts "h" opt; do
    case ${opt} in
        h )
            usage
            ;;
        \? )
            usage
            ;;
    esac
done
shift $((OPTIND -1))

# Check if a date was provided
if [ -z "$1" ]; then
    echo "Error: Date argument is required."
    usage
fi

# Check if the date is in the right format
if ! date -d "$1" >/dev/null 2>&1; then
    echo "Error: Invalid date format. Please provide the date in the format YYYY-MM-DD."
    usage
fi

# Get the day of the week
day=$(date -d "$1" +%A)

echo "The date $1 is on a $day."
