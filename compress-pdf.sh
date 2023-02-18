#!/bin/bash

# Check if Ghostscript is installed
if ! command -v gs &> /dev/null; then
  echo "Ghostscript is not installed. Please install Ghostscript and try again."
  exit 1
fi

if [ "$#" -ne 1 ]; then
  echo "Usage: $0 <pdf_file>"
  exit 1
fi

pdf_file="$1"

if [ ! -f "$pdf_file" ]; then
  echo "File '$pdf_file' not found."
  exit 1
fi

read -p "Enter compression level (1-100): " compression_level

if [[ ! "$compression_level" =~ ^[1-9][0-9]?$|^100$ ]]; then
  echo "Invalid compression level. Please enter a number between 1 and 100."
  exit 1
fi

output_file="${pdf_file%.*}-compressed.pdf"

gs -sDEVICE=pdfwrite -dCompatibilityLevel=1.4 -dPDFSETTINGS=/screen -dNOPAUSE -dQUIET -dBATCH -dColorImageDownsampleType=/Bicubic -dColorImageResolution=$compression_level -dGrayImageDownsampleType=/Bicubic -dGrayImageResolution=$compression_level -dMonoImageDownsampleType=/Bicubic -dMonoImageResolution=$compression_level -sOutputFile="$output_file" "$pdf_file"

echo "Compression completed."

read -p "Do you want to save the compressed PDF in the same directory? [y/n] " answer

if [[ "$answer" =~ ^[Yy]$ ]]; then
  echo "Compressed PDF saved as: $output_file"
else
  read -p "Enter the path to the directory where you want to save the compressed PDF: " dir_path
  if [ ! -d "$dir_path" ]; then
    echo "Directory not found."
    exit 1
  fi

  cp "$output_file" "$dir_path"
  echo "Compressed PDF saved as: $dir_path/$output_file"
fi

exit 0
