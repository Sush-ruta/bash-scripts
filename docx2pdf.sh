#!/bin/bash
# A bash script to convert a doc or docx file to pdf using libreoffice
input=$1 # get input file name from command line argument
if [ -z "$input" ]; then # check if input is empty
  echo "Please provide a file name as input."
  exit 1
fi
if [[ $input != *.doc && $input != *.docx ]]; then # check if input is doc or docx file
  echo "Please provide a doc or docx file as input."
  exit 2
fi
type libreoffice &> /dev/null # check if libreoffice is installed [^1^][3]
if [ $? -eq 0 ]; then # if yes, convert file to pdf
  soffice --convert-to pdf "$input"
  echo "Conversion done!"
else # if no, print error message
  echo "Libreoffice is not installed on your system."
  exit 3
fi
