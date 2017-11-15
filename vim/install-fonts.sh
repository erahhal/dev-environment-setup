#!/bin/bash

set -

cd ~/Code-vendor/
if [ ! -e nerd-fonts ]; then
    git clone https://github.com/ryanoasis/nerd-fonts
fi
cd nerd-fonts
./install.sh
