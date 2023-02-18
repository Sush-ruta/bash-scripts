#!/usr/bin/env bash

# Check if Pandoc is installed
if ! command -v pandoc &> /dev/null; then
    echo "Pandoc is not installed. Please install Pandoc and try again."
    exit 1
fi

# Check if xelatex is installed
if ! command -v xelatex &> /dev/null; then
    echo "xelatex is not installed. Do you want to switch to pdflatex? (y/n)"
    read -r switch_engine

    if [[ "$switch_engine" == "y" ]]; then
        if ! command -v pdflatex &> /dev/null; then
            echo "pdflatex is not installed. Please install pdflatex and try again."
            exit 1
        else
            echo "Using pdflatex engine"
            pdf_engine="pdflatex"
        fi
    else
        echo "xelatex is required to generate PDF files. Please install xelatex and try again."
        exit 1
    fi
else
    pdf_engine="xelatex"
fi

# Check if a file was provided as an argument
if [ -z "$1" ]; then
    echo "Please provide a markdown file as an argument."
    exit 1
fi

# Check if the provided file is a markdown file
filename="$1"
extension="${filename##*.}"
if [[ ! "$extension" =~ ^(md|mkd|mdwn|mdown|mdtxt|mdtext|markdown|text)$ ]]; then
    echo "The provided file is not a markdown file."
    exit 1
fi

# Set default PDF style
pdf_style="default"

# Ask user for PDF style
echo "Enter 'light' or 'dark' for PDF style (default is 'light'): "
read style_input
if [[ "$style_input" == "dark" ]]; then
    pdf_style="eisvogel-dark"
fi

# Generate PDF from markdown file
pandoc "$filename" --pdf-engine="$pdf_engine" --template="$pdf_style" --highlight-style=pygments -o "${filename%.*}.pdf"

echo "PDF generated: ${filename%.*}.pdf"
