#!/bin/bash

# Define usage function
function usage {
  echo "Usage: d [-h] [-o OUTPUT] URL"
  echo "Download a file using axel, aria2c, wget, or curl"
  echo
  echo "Positional arguments:"
  echo "  URL                   URL of the file to download"
  echo
  echo "Optional arguments:"
  echo "  -h, --help            Show this help message and exit"
  echo "  -o OUTPUT, --output OUTPUT"
  echo "                        Output file name"
}

# Parse command line options
while [[ $# -gt 0 ]]; do
  case $1 in
    -h|--help)
      usage
      exit 0
      ;;
    -o|--output)
      output="$2"
      shift 2
      ;;
    *)
      url="$1"
      shift
      ;;
  esac
done

# Check if a URL is given as an argument
if [ -z "$url" ]; then
  echo "Error: no URL specified."
  usage
  exit 1
fi

# Download the URL using axel, if available
if command -v axel >/dev/null 2>&1; then
  echo "Using axel to download the URL..."
  if [ -n "$output" ]; then
    axel -n 10 -o "$output" -a "$url"
  else
    axel -n 10 -a "$url"
  fi
  exit 0
fi

# Download the URL using aria2c, if available
if command -v aria2c >/dev/null 2>&1; then
  echo "Using aria2c to download the URL..."
  if [ -n "$output" ]; then
    aria2c -x 10 -o "$output" "$url"
  else
    aria2c -x 10 "$url"
  fi
  exit 0
fi

# Download the URL using wget, if available
if command -v wget >/dev/null 2>&1; then
  echo "Using wget to download the URL..."
  if [ -n "$output" ]; then
    wget -c -O "$output" "$url"
  else
    wget -c "$url"
  fi
  exit 0
fi

# Download the URL using curl, if available
if command -v curl >/dev/null 2>&1; then
  echo "Using curl to download the URL..."
  if [ -n "$output" ]; then
    curl -C - -o "$output" "$url"
  else
    curl -C - -O "$url"
  fi
  exit 0
fi

# If none of the download managers are available, exit with an error message
echo "Error: No download managers found."
exit 1
