#!/bin/sh
                               
DIR="$( cd "$( dirname "$0" )" && pwd )"

ln -s $DIR/Scripts ~/Scripts
ln -s $DIR/bash/bashrc ~/.bashrc
ln -s $DIR/bash/bash_profile ~/.bash_profile
ln -s $DIR/vim/vimrc ~/.vimrc     
mkdir -p ~/.vim                
git clone https://github.com/gmarik/vundle.git ~/.vim/bundle/vundle
vim -c "execute 'BundleInstall' | qa"
cp -R ~/.vim/bundle/vim-colors-solarized/colors ~/.vim

