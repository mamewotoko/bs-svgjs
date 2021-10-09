#! /bin/bash
UNAME=$(uname)
if [ "$UNAME" = "Darwin" ]; then
    brew install npm
elif [ "$UNAME" = "Linux" ]; then
    sudo apt update
    sudo apt install -y npm
fi
npm update npm
npm install
