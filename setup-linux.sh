#!/bin/bash
                               
DIR="$( cd "$( dirname "$0" )" && pwd )"

#-------------------------------------------------------------
# Linux
#-------------------------------------------------------------

arch=`uname -m`
if [[ "$arch" == "i686" ]]; then
  echo "Linux i686"
elif [[ "$arch" == "x86_64" ]]; then
  echo "Linux x86_64"
else
  # Unknown architecture
  echo "Unknown architecture"
  exit 1
fi

if hash apt-get 2>/dev/null; then
  sudo apt-get update
  sudo apt-get install -y python-software-properties vim postgresql nginx cmake python-dev dconf
  sudo add-apt-repository -y ppa:chris-lea/node.js
  sudo add-apt-repository -y ppa:fcwu-tw/ppa
  sudo apt-get update            
  sudo apt-get install -y nodejs
  sudo apt-get install -y ack-grep vim
elif hash yum 2>/dev/null; then
  sudo yum install -y ack
else
  echo "Unknown distribution"
  exit 1
fi

cd ~/Code-vendor
git clone https://github.com/Anthony25/gnome-terminal-colors-solarized.git
cd gnome-terminal-colors-solarized
./set_dark.sh
