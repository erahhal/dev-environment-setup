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
  sudo apt-get install -y python-software-properties vim postgresql nginx
  sudo add-apt-repository -y ppa:chris-lea/node.js
  sudo apt-get update            
  sudo apt-get install -y nodejs
  sudo apt-get install -y ack-grep vim
elif hash yum 2>/dev/null; then
  sudo yum install -y ack
else
  echo "Unknown distribution"
  exit 1
fi
