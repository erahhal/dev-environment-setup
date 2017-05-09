#!/bin/bash

if [ "$(uname)" == "Darwin" ]; then
  brew update
  brew upgrade neovim
  gem install neovim
  pip install --upgrade neovim
else
  sudo apt update
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

