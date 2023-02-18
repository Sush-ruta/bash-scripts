#!/usr/bin/env bash

# Check if Ghostscript is installed
if ! command -v gs &> /dev/null
then
    echo "Ghostscript is not installed. Aborting."
    exit 1
fi

# Check if a PDF file has been provided as argument
if [ -z "$1" ]
then
    echo "Usage: $0 <pdf-file>"
    exit 1
fi

# Extract the file name and extension from the provided PDF file
filename=$(basename "$1")
extension="${filename##*.}"
filename="${filename%.*}"

# Create a directory to store the output PNG files
mkdir -p "${filename}_pngs"

# Convert each page of the PDF file to a PNG file
gs -dSAFER -dBATCH -dNOPAUSE -sDEVICE=png16m -r300 -sOutputFile="${filename}_pngs/page_%04d.png" "$1"
