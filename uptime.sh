#!/bin/bash

# Check if lolcat is installed, fallback to plain output otherwise
if command -v lolcat &> /dev/null; then
  color_output="lolcat"
else
  color_output="cat"
fi

# Parse command line arguments
while [[ "$#" -gt 0 ]]; do
    case $1 in
        -h|--help) 
            echo "Usage: ./uptime.sh [-h|--help]"
            echo "Prints the system uptime as a Tux the penguin ASCII art"
            echo ""
            echo "Options:"
            echo "-h, --help  Print usage information"
            exit 0
            ;;
        *) 
            echo "Unknown parameter passed: $1"
            exit 1
            ;;
    esac
    shift
done

# Calculate system uptime in seconds
uptime_seconds=$(awk '{print $1}' /proc/uptime | cut -d '.' -f 1)

# Convert uptime to days, hours, minutes, seconds
days=$((uptime_seconds / 86400))
hours=$((uptime_seconds % 86400 / 3600))
minutes=$((uptime_seconds % 3600 / 60))
seconds=$((uptime_seconds % 60))

# Print system uptime as Tux the penguin ASCII art
printf "%s\n" "
          _______
         |.-----.|
         ||x . x||
         ||_.-._||
         \`--)-(--\`
        __[=== o]___
       |:::::::::::|
    ___|:::::::::::|___
   (   )_____________(   )
"
printf "System Uptime: %d days, %02d:%02d:%02d\n" $days $hours $minutes $seconds | $color_output
