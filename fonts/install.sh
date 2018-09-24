#!/bin/bash

set -euo pipefail

if [ ! -e ~/.fonts/SourceCodePro-Regular.otf ]; then
    I1FS=$'\n\t'
    mkdir -p /tmp/adobefont
    cd /tmp/adobefont
    wget -q --show-progress -O source-code-pro.zip https://github.com/adobe-fonts/source-code-pro/archive/2.030R-ro/1.050R-it.zip
    unzip -q source-code-pro.zip -d source-code-pro
    mkdir -p ~/.fonts
    sudo cp -v source-code-pro/*/OTF/*.otf /usr/local/share/fonts/
    rm -rf source-code-pro{,.zip}
fi

cd ~/Code-vendor/
if [ ! -e nerd-fonts ]; then
    git clone https://github.com/ryanoasis/nerd-fonts
fi
cd nerd-fonts
./install.sh

sudo fc-cache -f
