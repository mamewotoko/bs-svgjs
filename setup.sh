#! /bin/bash
set -e
UNAME=$(uname)
if [ "$UNAME" = "Darwin" ]; then
    brew install npm yarn
    npm update npm
    npm install
    $(npm bin)/yarn add bsdoc@6.0.4-alpha
elif [ "$UNAME" = "Linux" ]; then
    sudo apt update
    sudo apt install -y npm
    npm update npm
    npm install yarn
    npm install
    $(npm bin)/yarn add @mauna-ai/bsdoc-linux
fi
