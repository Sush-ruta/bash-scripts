#!/bin/bash

API_KEY=""

# Check if pdflayer API key is set in script
if [ -z "$API_KEY" ]; then
    echo "Please enter your pdflayer API key: "
    read API_KEY
fi

# Check if jq is installed
if ! command -v jq &> /dev/null; then
    echo "jq is not installed. Please install jq and try again."
    exit 1
fi

# Check if the user requests help
if [[ "$1" == "--help" ]]; then
    echo "Usage: ./html-to-pdf.sh [OPTIONS] [HTML_FILE]

Converts an HTML file to PDF using the pdflayer API.

Options:
  --key      Set pdflayer API key
  --help     Show this help message"

    exit 0
fi

# Check for API key switch
if [[ "$1" == "--key" ]]; then
    API_KEY="$2"
    echo "pdflayer API key updated successfully."
    exit 0
fi

# Check if an HTML file is provided as an argument
if [ -z "$1" ]; then
    echo "Please provide an HTML file as an argument."
    exit 1
fi

# Check if the provided file is an HTML file
filename="$1"
extension="${filename##*.}"
if [ "$extension" != "html" ]; then
    echo "The provided file is not an HTML file."
    exit 1
fi

# Send request to pdflayer API to convert HTML to PDF
response=$(curl -s "https://api.pdflayer.com/api/convert?access_key=$API_KEY&document_url=file://$PWD/$filename")

# Check if the API returned an error
if [[ $(echo "$response" | jq -r '.success') != "true" ]]; then
    echo "API error: $(echo "$response" | jq -r '.error.info')"
    exit 1
fi

# Save the PDF to a file
pdf_filename="${filename%.*}.pdf"
echo "$response" | jq -r '.url' | xargs curl -s -o "$pdf_filename"

echo "PDF generated: $pdf_filename"
