#!/bin/bash

# Check if litime is installed
if ! command -v litime &> /dev/null
then
    # Install litime through rustup
    echo "litime is not installed. Installing through rustup..."
    rustup update
    cargo install litime
    echo "litime is now installed!"
fi

# Run litime
litime --main-colour white --author-colour green --time-colour red
