#!/bin/bash
DIR="$( cd "$( dirname "$0" )" && pwd )"

if [ "$(uname)" == "Darwin" ]; then
  brew update
  brew install neovim
  brew upgrade neovim
  gem install neovim
  pip install --upgrade neovim
else
  sudo apt update
  sudo apt install -y neovim
  sudo apt upgrade -y neovim
  sudo gem install neovim
  sudo pip2 install --upgrade neovim
  sudo pip3 install --upgrade neovim
fi

vim -c "execute 'PlugUpgrade' | qa"
vim -c "execute 'PlugUpdate' | qa"
vim -c "execute 'PlugInstall' | qa"
vim -c "execute 'PlugClean!' | qa"
vim -c "execute 'UpdateRemotePlugins' | qa"

$DIR/ycm-update.sh
