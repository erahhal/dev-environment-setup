#!/bin/bash

set -e

cd ~/Code-vendor

if [ ! -e tidy-html5 ]; then
    git clone https://github.com/htacg/tidy-html5.git
fi
cd tidy-html5
cd build/cmake
cmake ../.. -DCMAKE_BUILD_TYPE=Release
make
sudo make install

