#!/bin/bash
                               
DIR="$( cd "$( dirname "$0" )" && pwd )"

#-------------------------------------------------------------
# Bash
#-------------------------------------------------------------

if [ "$DIR/Scripts" != "$(ls -l ~/Scripts | awk '{print $11}')" ]; then
  mv ~/Scripts ~/Scripts.orig
  ln -s $DIR/Scripts ~/Scripts
fi
if [ "$DIR/bash/bashrc" != "$(ls -l ~/.bashrc | awk '{print $11}')" ]; then
  mv ~/.bashrc ~/.bashrc.orig
  ln -s $DIR/bash/bashrc ~/.bashrc
fi
if [ "$DIR/bash/bash_profile" != "$(ls -l ~/.bash_profile | awk '{print $11}')" ]; then
  mv ~/.bash_profile ~/.bash_profile.orig
  ln -s $DIR/bash/bash_profile ~/.bash_profile
fi

#-------------------------------------------------------------
# Platform specific
#-------------------------------------------------------------

if [ "$(uname)" == "Darwin" ]; then
  $DIR/setup-osx.sh
elif [ "$(expr substr $(uname -s) 1 5)" == "Linux" ]; then
  $DIR/setup-linux.sh
elif [ "$(expr substr $(uname -s) 1 10)" == "MINGW32_NT" ]; then
  #-------------------------------------------------------------
  # Cygwin
  #-------------------------------------------------------------
  echo "Cygwin"
else
  # Unknown platform
  echo "Unknown platform"
fi

#-------------------------------------------------------------
# Node
#-------------------------------------------------------------

sudo npm install -g bower
sudo npm install -g grunt-cli

#-------------------------------------------------------------
# Python
#-------------------------------------------------------------

# for FormatJSON command in VIM
pip install simplejson

#-------------------------------------------------------------
# VIM
#-------------------------------------------------------------

if [ "$DIR/vim/vimrc" != "$(ls -l ~/.vimrc | awk '{print $11}')" ]; then
  mv ~/.vimrc ~/.vimrc.orig
  ln -s $DIR/vim/vimrc ~/.vimrc     
fi
mkdir -p ~/.vim                
if [ ! -e ~/.vim/bundle/vundle ]; then
  git clone https://github.com/gmarik/vundle.git ~/.vim/bundle/vundle
fi
vim -c "execute 'BundleInstall' | qa"
cp -R ~/.vim/bundle/vim-colors-solarized/colors ~/.vim
cd ~/.vim/bundle/YouCompleteMe
./install.sh --clang-completer
cd ~/.vim/bundle/tern_for_vim
sudo npm install -g
cd ~/.vim/bundle/Command-T/ruby/command-t/
ruby extconf.rb
make

#-------------------------------------------------------------
# IRSSI
#-------------------------------------------------------------

if [ "$DIR/irssi" != "$(ls -l ~/.irssi | awk '{print $11}')" ]; then
  mv ~/.irssi ~/.irssi.orig
  ln -s $DIR/irssi ~/.irssi     
fi

#-------------------------------------------------------------
# 3rd party code
#-------------------------------------------------------------

mkdir -p ~/Code-vendor
