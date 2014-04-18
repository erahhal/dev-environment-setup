#!/bin/sh
                               
DIR="$( cd "$( dirname "$0" )" && pwd )"

#-------------------------------------------------------------
# Bash
#-------------------------------------------------------------

ln -s $DIR/Scripts ~/Scripts
ln -s $DIR/bash/bashrc ~/.bashrc
ln -s $DIR/bash/bash_profile ~/.bash_profile

#-------------------------------------------------------------
# VIM
#-------------------------------------------------------------

ln -s $DIR/vim/vimrc ~/.vimrc     
mkdir -p ~/.vim                
git clone https://github.com/gmarik/vundle.git ~/.vim/bundle/vundle
vim -c "execute 'BundleInstall' | qa"
cp -R ~/.vim/bundle/vim-colors-solarized/colors ~/.vim

#-------------------------------------------------------------
# Platform specific
#-------------------------------------------------------------

if [ "$(uname)" == "Darwin" ]; then
  #-------------------------------------------------------------
  # Mac
  #-------------------------------------------------------------

  # Install homebrew
  ruby -e "$(curl -fsSL https://raw.github.com/Homebrew/homebrew/go/install)"

elif [ "$(expr substr $(uname -s) 1 5)" == "Linux" ]; then
  #-------------------------------------------------------------
  # Linux
  #-------------------------------------------------------------

  arch=`uname -m`
  if [[ "$arch" == "i686" ]]; then
  elif [[ "$arch" == "x86_64" ]]; then
  else
    # Unknown architecture
    echo "Unknown architecture"
    exit 1
  fi
elif [ "$(expr substr $(uname -s) 1 10)" == "MINGW32_NT" ]; then
  #-------------------------------------------------------------
  # Cygwin
  #-------------------------------------------------------------
else
  # Unknown platform
fi
