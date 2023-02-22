#!/bin/bash

# Check if tilix is installed
if ! command -v tilix &> /dev/null
then
    echo "tilix is not installed, please install it."
    exit
fi

# Check if tilix-split.json exists
if [ ! -f ~/.config/tilix-split.json ]; then
    echo "tilix-split.json file not found. Downloading from https://gist.github.com/Sush-ruta/8b93935873fc230faf462b30f6b3ae65/raw/bac1c7662d03b0a69af5c48fa13cb09baf8f1422/tilix-split.json..."
    mkdir -p ~/.config
    wget https://gist.github.com/Sush-ruta/8b93935873fc230faf462b30f6b3ae65/raw/bac1c7662d03b0a69af5c48fa13cb09baf8f1422/tilix-split.json -O ~/.config/tilix-split.json
    echo "tilix-split.json file saved in ~/.config folder."
fi

# Launch Tilix with saved session
tilix --session=~/.config/tilix-split.json
