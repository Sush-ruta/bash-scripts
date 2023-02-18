#!/bin/bash

# Define usage function
usage() {
    echo "Usage: $(basename "$0") [OPTIONS] INPUT_PDF"
    echo "Prompt the user for the password and remove password protection from PDF."
    echo
    echo "Options:"
    echo "  -h, --help          Show this help message and exit"
    echo
    exit 1
}

# Check if qpdf is installed, fall back to pdftk if not
if command -v qpdf >/dev/null 2>&1; then
    pdf_tool="qpdf"
elif command -v pdftk >/dev/null 2>&1; then
    pdf_tool="pdftk"
else
    echo "Error: Neither qpdf nor pdftk found in system."
    exit 1
fi

# Parse command-line arguments
while [[ $# -gt 0 ]]; do
    case $1 in
        -h|--help)
            usage
            ;;
        -*)
            echo "Error: Unrecognized option: $1"
            usage
            ;;
        *)
            if [[ -n "$input_pdf" ]]; then
                echo "Error: Too many arguments provided."
                usage
            else
                input_pdf="$1"
            fi
            ;;
    esac
    shift
done

# Check that input file was provided
if [[ -z "$input_pdf" ]]; then
    echo "Error: No input PDF file provided."
    usage
fi

# Prompt the user for the password
read -sp "Enter password to decrypt $input_pdf: " pdf_password
echo

# Remove password protection from PDF
if [[ "$pdf_tool" == "qpdf" ]]; then
    output_pdf="${input_pdf%.*}-unlocked.pdf"
    qpdf --password="$pdf_password" --decrypt "$input_pdf" "$output_pdf"
else
    output_pdf="${input_pdf%.*}-unlocked.pdf"
    pdftk "$input_pdf" input_pw "$pdf_password" output "$output_pdf" allow AllFeatures
fi

echo "Password protection removed from $input_pdf."
echo "Output file: $output_pdf"
