#!/bin/bash

# check if ImageMagick is installed
if ! command -v convert &> /dev/null; then
    echo "Error: ImageMagick is not installed. Aborting."
    exit 1
fi

# check if an argument was passed
if [ $# -ne 1 ]; then
    echo "Usage: $0 [jpg or jpeg file]"
    exit 1
fi

# check if the file is a JPEG image
if [[ ! "$1" =~ .*\.jpe?g$ ]]; then
    echo "Error: The input file must be a JPEG image."
    exit 1
fi

# set output file name
output_file="${1%.*}.pdf"

# convert the file
convert "$1" "$output_file"

# check if the conversion was successful
if [ $? -eq 0 ]; then
    echo "File successfully converted to PDF"
else
    echo "Error: Failed to convert file to PDF."
fi
