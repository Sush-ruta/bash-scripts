#!/bin/bash

# Display the usage information
function display_usage {
    echo "Usage: $(basename "$0") [-h]"
    echo "  -h, --help    Display this help and exit"
}

# Check for the help option
if [[ $1 == "-h" || $1 == "--help" ]]; then
    display_usage
    exit 0
fi

# Get the total size of the current directory
total_size=$(du -sh . | awk '{print $1}')

# Get the number of files and folders in the current directory
num_files=$(find . -type f | wc -l)
num_dirs=$(find . -type d | wc -l)

# Display the results
echo "Total size of $(pwd): $total_size"
echo "Number of files: $num_files"
echo "Number of directories: $num_dirs"
